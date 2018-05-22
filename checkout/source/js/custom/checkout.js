//
// check out
//

(function(){
    
    //
    // Wait for content to load
    //
    
    $(function(){
        
        var container = $("[data-js=form-content");

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
    // Ajust container HTML
    //

    function init($el){

        var checkEl = setInterval( 
        
        function(){
        
            var el = $("[data-js=form-content]");
            
            if(el.length === 1) {
                
                clearInterval(checkEl);
                
                owlInit(el);
                
                validationInit(el);


                // disable form submit on keypress "Enter"

                el.parents('[data-js=form]').on('keyup keypress', function(e) {

                    var keyCode = e.keyCode || e.which;

                    if (keyCode === 13) { 
                        e.preventDefault();
                        return false;
                    }
                });
                
            }
            
        }, 250);

    }
    
    //
    // Owl init
    //
    
    function owlInit($el){
        
        $el.owlCarousel({
            responsive: true,
            pagination: true,
            singleItem: true,
            touchDrag: false,
            mouseDrag: false,
            numbers: true,
            afterInit: customPager,
            afterUpdate: customPager,
        });
        
        $el.on('click', "[data-js=owlNext]", function(e){
            
            e.preventDefault();

            $(this).parents('[data-js=sect]').find('input').blur();
             
            var errorInputs = $(this).parents('[data-js=sect]').find('input.error');
            
            if(errorInputs.length){
                
                alert('please fill out all required feilds "*"');
                
            }else{
                $el.trigger('owl.next');
                
                $('body, html').animate({
    				scrollTop : $el.offset().top - 100
    			}, 500);
    			
            }
        });
        
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
                    dotText = titleData.slice(0, 1);
                
                titleData = titleData.slice( 3, titleData.length);

                $(paginationLinks[i]).html( titleData + '<span class="owl-page-number">'+ dotText +'</span>');

            }
            
        );
        
    }

    //
    // validation
    //
    
    function validationInit($el){
        
        // JQuery validator
        
        $.validate({ form: '#checkoutForm'});
        
        // custom made checkboxes
        
        $el.on('click', '[data-js=checkbox]', 
            
            function(){
            
                $(this).parents('.checkbox').siblings().slideToggle();
                $(this).parents('.checkbox').siblings().find('input').val('');
                
            }
        );
        
    }

})();