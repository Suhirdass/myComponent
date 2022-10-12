({
    render : function(c, helper) {
        var ret = this.superRender();
        const userAgent = navigator.userAgent.toLowerCase();
        const isTablet = /(ipad|tablet|(android(?!.*mobile))|(windows(?!.*phone)(.*touch))|kindle|playbook|silk|(puffin(?!.*(IP|AP|WP))))/.test(userAgent);
        console.log('isTablet = ',isTablet)
        var productFamilies = c.get('v.productFamiliesAll');
        if(isTablet){
            var productFamilies = productFamilies.slice(0, 3);
            c.set('v.productFamilies', productFamilies);
            c.set('v.groupedFamilies', productFamilies.slice(3, productFamilies.length));
        } else {
            var productFamilies = productFamilies.slice(0, 6);
            c.set('v.productFamilies', productFamilies);
            c.set('v.groupedFamilies', productFamilies.slice(6, productFamilies.length));
        }
        return ret;
    },
	// Your renderer method overrides go here
})