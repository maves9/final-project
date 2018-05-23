//
// check out
//

(function(){
    
    //
    // Wait for content to load
    //
    
    $(function(){
        
        var container = $("[data-js=form-content]");

        // hide while loading
        
        container.css('opacity', '0');
        
        var checkDisplay = setInterval(function(){

            // if the main container is vissible init

            if(container.parents('#m-checkout').css('display') == 'block') {
                
                clearInterval(checkDisplay);
                
                init(container);
                
                container.css('opacity', '1');
            }
            
        }, 250);
            
    });

    //
    // init
    //

    function init($el){
            
        if($el.length === 1) {
            
            owlInit($el);
            
            validationInit($el);

            // disable form submit on keypress "Enter"

            $el.parents('[data-js=form]').on('keyup keypress', function(e) {

                var keyCode = e.keyCode || e.which;

                if (keyCode === 13) { 
                    e.preventDefault();
                    return false;
                }
            });

        }

    }
    
    //
    // Owl init
    //
    
    function owlInit($el){
        
        $el.owlCarousel({
            responsive: true,         // responsive features
            pagination: true,         // create pagination elements
            singleItem: true,         // make each slide item full width
            touchDrag: false,         // disable touch dragging
            mouseDrag: false,         // disable mouse dragging
            numbers: true,            // make numbers on pagination
            afterInit: customPager,   // execute function after this
            afterUpdate: customPager, // execute on slide changes
        });
        
        $el.on('click', "[data-js=owlNext]", function(e){
            
            // prevent button from submitting the form

            e.preventDefault();

            // blur all feilds to see if theres validation errors

            $(this).parents('[data-js=sect]').find('input').blur();

            // find error class
             
            var errorInputs = $(this).parents('[data-js=sect]').find('input.error');
            
            // validate

            if(errorInputs.length){
                
                alert('please fill out all required feilds "*"');
                
            }else{
                $el.trigger('owl.next');
                
                // scroll to the beginig of the section

                $('body, html').animate({
    				scrollTop : $el.offset().top - 100
    			}, 500);
    			
            }
        });

        // back button
        
        $el.on('click', "[data-js=owlPrev]", function(e){

            e.preventDefault();

            $el.trigger('owl.prev');

        });

    }
    
    //
    // create pagination labels
    //
    
    function customPager() {

        $.each( this.owl.userItems,
        
            function (i) {
                var titleData = $(this).find('[data-js=title]').text(),
                    paginationLinks = $('.owl-controls .owl-pagination .owl-page'),
                    titleNumber = titleData.slice(0, 1);
                
                // remove number from title
                
                titleData = titleData.slice( 3, titleData.length);

                //apply new HTML to pagination item

                $(paginationLinks[i]).html( titleData + 
                    '<span class="owl-page-number">'+ titleNumber +'</span>');

            }
            
        );
        
    }

    //
    // validation
    //
    
    function validationInit($el){
        
        // JQuery validator
        
        $.validate({ form: '[data-js=form]'});
        
        // custom made checkboxes
        
        $el.on('click', '[data-js=checkbox]', 
            
            function(){
            
                $(this).parents('.checkbox').siblings().slideToggle();

                // clear input values on check/uncheck

                $(this).parents('.checkbox').siblings().find('input').val('');
                
            }
        );
        
    }

})();