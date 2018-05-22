{*

# Description
Checkout template partial, where customers input all the data (includes step 1, 2, 3, 4 and 5). Part of Checkout page type.


## Date last modified
2017-05-19


## Primary variables
+ $boxes                                                    			- Global scope variable containing column boxes
+ $columns                                                  			- Global scope variable containing columns


## Partials (templates)
+ "/modules/widgets/order/order.tpl"                        			- Template widget for the User Order Details
+ "/modules/checkout/partials/checkout-step1.tpl"						- Template partial containing step 1 info
+ "/modules/checkout/partials/checkout-step2.tpl"						- Template partial containing step 2 info
+ "/modules/checkout/partials/checkout-step3.tpl"						- Template partial containing step 3 info
+ "/modules/checkout/partials/checkout-step4.tpl"						- Template partial containing step 4 info
+ "/modules/checkout/partials/checkout-step5.tpl"						- Template partial containing step 5 info

*}

{* Add required JS asset *}
{addScript src='modules/checkout/includes/js/checkout.js'}

{* Define standard class for columns *}
{$stepClass = "col-s-4 col-m-6 col-l-6 col-xl-12"}

{* Calculate number of columns needed *}
{if $columns gt 0}
	{$stepClass = "col-s-4 col-m-12 col-l-12 col-xl-24"}
{/if}

{if !isset($user)}
	{include file="modules/widgets/modal/modal.tpl" dataId="1" dataType="widget" dataClose="true" dataTarget="login" dataRequest="{$page.request}"}
{/if}

{assign var=stepNum value=1}

<div class="checkoutLoading preloader text-center"><img alt="" src="{$template.cdn}/_design/common/img/preloader/preloader-black.gif"></div>

<div class="checkoutFrame m-checkout" id="m-checkout" style="display:none;" itemscope itemtype="http://schema.org/CheckoutPage">
	<div class="row">
		<form action="/actions/checkout/checkAll" method="post" id="checkoutForm" data-js="form" class="checkoutForm" autocomplete="off">
			{csrf type="input"}
		    <input id="check_stage_all_loaded" type="hidden" name="check_stage_all_loaded" value="0" />
		    {* Owl Init *}
            <div data-js="form-content" class="{$stepClass}">

				<div class="stepColumn column1" data-js="sect">
					<div class="step1 panel panel-border">
						<div class="panel-body">
							<div class="stepColumnInnerWrapper">
								<div class="stepContainer box1">
									<div class="stepHeader box1">
										<div class="title" data-js="title"><span class="h5"><span class="stepNumber"></span> {$Text.CHECKOUT_STEP_ONE}</span></div>
										<hr>
										{if !$user && $access.user}
											
										<h5>I have a user</h5>

											<div class="stepHeaderLogin"><a href="#modal1" class="button button-default is-block fancybox-modal">{$Text.CHECKOUT_STEP_ONE_ALREADY_CREATED}</a></div>
											<hr>
											{if $access.userLookup}
												<div class="stepHeaderLookup">
													{include file='modules/widgets/userlookup/userlookup.tpl'}
												</div>
											{/if}
										{/if}
									</div>
									<div class="stepBox">
										<h5>New customer</h5>
							    		{include file='modules/checkout/partials/checkout-step1.tpl'}
									</div>
								</div>
							</div>
						</div>
						{if $settings.module_shop_packing}
						<div class="step3 panel panel-border">
							<div class="panel-body">
								<div class="stepColumnInnerWrapper">
									<div class="stepContainer box3">
										<div class="stepHeader box3">
											<div class="title" data-js="title"><span class="h5"><span class="stepNumber"></span> {$Text.CHECKOUT_STEP_THREE}</span></div>
											<hr>
										</div>
										<div class="stepBox">
											{include file='modules/checkout/partials/checkout-step3.tpl'}
										</div>
									</div>
								</div>
							</div>
						</div>
						{/if}
						<div class="text-center padding-bot">
	                    	<button data-js="owlNext" class="button"> {$text.NEXT} <i class="fa fa-arrow-right"></i></button>
	                	</div>
					</div>
				</div>
				
				{if !$settings.shop_delivery_hidden}
				<div class="step2 panel panel-border" data-js="sect">
					<div class="panel-body">
						<div class="stepColumnInnerWrapper">
							<div class="stepContainer box2">
								<div class="stepHeader box2">
									<div class="title" data-js="title"><span class="h5"><span class="stepNumber"></span> {$Text.CHECKOUT_STEP_TWO}</span></div>
									<hr>
								</div>
								<div class="stepBox">
									{include file='modules/checkout/partials/checkout-step2.tpl'}
								</div>
							</div>
						</div>
					</div>
					<div class="text-center padding-bot">
                    
                        <button data-js="owlPrev" class="button"><i class="fa fa-arrow-left"></i> {$text.BACK} </button>
                    
                        <span data-js="owlNext" class="button"> {$text.NEXT} <i class="fa fa-arrow-right"></i></span>
                        
                    </div>
				</div>
				{/if}
				<div class="step4 panel panel-border" data-js="sect">
					<div class="panel-body">
						<div class="stepColumnInnerWrapper">
							<div class="stepContainer box4">
								<div class="stepHeader box4">
									<div class="title" data-js="title"><span class="h5"><span class="stepNumber"></span> {$Text.CHECKOUT_STEP_FOUR}</span></div>
									<hr>
								</div>
								<div class="stepBox">
								{include file='modules/checkout/partials/checkout-step4.tpl'}
									<div class="conditions">
                                        <div class="termsAndConditionsContainer">
                                            <fieldset class="form-group">
                                                <div class="input-group">
                                                    <span class="input-group-addon">
                                                        <input type="checkbox" name="acceptTerms" class="radiobtn" id="acceptTerms" value="1" {if $returnPostData.acceptTerms}checked{/if} required />
                                                    </span>
                                                    <label for="acceptTerms" class="form-label input-group-main">
                                                        <span>{$Text.CHECKOUT_STEP_FOUR_ACCEPT_TERMS}</span>
                                                        {if $termsLink}
                                                            <a class="termsAndConditionsLink fancybox" href="#overlayterms" target="_blank">{$Text.CHECKOUT_STEP_FOUR_ACCEPT_TERMS_LINK}</a>.
                                                        {/if}
                                                    </label>
                                                </div>
                                            </fieldset>
                                        </div>
                                    </div>
								</div>
							</div>
						</div>
					</div>

	            <div class="text-center padding-bot">
		        
		            <button data-js="owlPrev" class="button"><i class="fa fa-arrow-left"></i> {$text.BACK} </button>
		            <button type="submit" name="bestilling" class="button-primary">
	            {$text.CHECKOUT_CONFIRM}</button>
	        	</div>		
                            
				</div>

			</div>

			<div class="stepColumn column3 {$stepClass}">
				<div class="step5 panel panel-border">
					<div class="panel-body">
						<div class="stepColumnInnerWrapper">
							<div class="stepContainer box5">
								<div class="stepHeader">
									<div class="title"><span class="h5">{$Text.CHECKOUT_SUMMARY}</span></div>
									<hr>
								</div>
								<div class="stepBox">
									{include file='modules/checkout/partials/checkout-step5.tpl'}
								</div>

								<div class="stepBox">
									{include file="modules/checkout/partials/checkout-step5-conditions.tpl"}
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>