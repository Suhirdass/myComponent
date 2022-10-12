({
	onInit: function (c, e, h) {
		console.log('brandId:mm', sessionStorage.getItem('brandId'));
		c.set('v.recordId', sessionStorage.getItem('brandId'));        
		h.request(
			c,
			'getBrand',
			{ id: sessionStorage.getItem('brandId') },
			function (r) {
				console.log(r);
				c.set('v.brand', r.brand);
				try {
					c.set('v.mapMarkers', [
						{
							location: {
								Street: r.brand.street,
								City: r.brand.city,
								State: r.brand.state,
								Country: r.brand.country,
								PostalCode: r.brand.postalCode,
							},
							title: r.brand.brandDBA,
							description: '',
						},
					]);
				} catch (er) {
					console.log('Error:', er);
				}
				c.set('v.linecards', r.linecards);
				c.set('v.isBrand', r.isBrand);
				c.set('v.primaryContact', r.primaryContact);
				// Overview > Licenses Table
				c.set('v.columns', [
					{
						label: 'Address',
						fieldName: 'Address',
						type: 'text',
						wrapTextMaxLines: 3,
					},
					{ label: 'License Class', fieldName: 'LicenseClass', type: 'text' },
					{ label: 'License Type', fieldName: 'LicenseType', type: 'text' },
				]);
				c.set(
					'v.data',
					new Array(20).fill({}).map((val, id) => {
						return {
							id: id,
							Address: '21404 Orr Springs Road Ukiah, California 95482',
							LicenseClass: 'M License',
							LicenseType: 'Type 2',
						};
					})
				); 
                    
			}
		);
	},
	showBrandProducts: function (c, e, h) {
		console.log('showBrandProducts ...');
		try {
			var brand = c.get('v.brand');
			sessionStorage.setItem('initSearch', 1);
			//sessionStorage.setItem('searchTerm', brand.DBA);
			sessionStorage.setItem('brandId', brand.id);
			h.redirect('/products', true);
		} catch (e) {
			console.log('exception:', e);
		}
	},
	onAddLinecard: function (c, e, h) {
		$A.createComponent(
			'c:addToLineCard',
			{ retailer: c.get('v.brand'), isRetailer: false },
			function (content, status) {
				if (status === 'SUCCESS') {
					c.find('overlay').showCustomModal({
						body: content,
						showCloseButton: true,
						cssClass: 'cUtility fix-close-button slds-modal_medium',
					});
				}
			}
		);
	},
	onViewTicket: function (c, e, h) {
		var recordId = e.currentTarget.dataset.id;
		sessionStorage.setItem('retaildeliveryticketId', recordId);
		h.redirect('/viewretaildeliveryticket', true);
	},
	gotoDetails: function (c, e, h) {
		console.log(e);
		console.log(e.target);
		h.navigateToRecord(c, e.target.id, 'detail');
	},
        printDetails: function (c, e, h) {
            var currentUrl = window.location.href;
            currentUrl = currentUrl.replace('/s/brand','/apex/printBrandDetailPdf?id='+c.get('v.recordId'));
            console.log('currentUrl::',currentUrl);
            window.open(currentUrl,'_blank');
        }        
});