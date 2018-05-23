{*

# Description
Google Analytics widget. A widget is a small helper template, with some functionality.


## Date last modified
2015-01-05


## Primary variables
+ $settings                                                             - Global scope variable containing platform settings
+ $page                                                                 - Global scope variable containing all information about the page type


## Partials (templates)
No extra templates required for this template

*}

{if !empty($settings.api_google_analytics) and $settings.api_google_analytics !== false}
    <script id="google-analytics">
    {if isset($settings.google_analytics_type) and $settings.google_analytics_type === "universal"}
        {literal}
            (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
            (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
            m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
            })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
        {/literal}
            ga('create', '{$settings.api_google_analytics}', 'auto');

            {* require google optimize *}
            ga('require', 'GTM-TXSWDSN');

            ga('send', 'pageview');
        {* Analytics for e-commerce (transaction) *}
        {if $page.isCheckout and isset($smarty.get.approved) and !empty($page.orderId)}
            {orderTracking orderId=$page.orderId type="analytics"}
        {/if}
    
    {else}
    
        var _gaq = _gaq || [];
        _gaq.push(['_setAccount', '{$settings.api_google_analytics}']);
        _gaq.push(['_trackPageview']);
        {* Analytics for e-commerce (transaction)*}
        {if $page.isCheckout and isset($smarty.get.approved) and !empty($page.orderId)}
            {orderTracking orderId=$page.orderId type="analytics"}
        {/if}
        {literal}
            (function() {
                var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
                ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';
                var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
            })();
        {/literal}
    {/if}
    </script>
{/if}