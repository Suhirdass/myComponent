({
    onInit: function (c, e, h) {
        try {
            c.set('v.recordId', sessionStorage.getItem('retaildeliveryticketId'));
        } catch (err) { }
        
        h.request(c, 'getRetailDeliveryTicket', { recordId: c.get('v.recordId') }, function (r) {
            console.log("getRetailDeliveryTicket:",r);
            c.set('v.retailDeliveryTicket', r.retailDeliveryTicket);
            c.set('v.retailDeliveryTicketLineItems', r.retailDeliveryTicketLineItems);            
            var relatedContacts = r.relatedContacts || [];
            var selectedContactIds = (relatedContacts.length?r.retailDeliveryTicket.retailerContact+';'+relatedContacts.join(';'):r.retailDeliveryTicket.retailerContact);
            c.set('v.selectedContactIds',selectedContactIds);
            
            var contactsOptions = [];
            if(r.contacts && r.contacts.length){
                for(var i=0;i<r.contacts.length;i++){
                    contactsOptions.push({label: r.contacts[i].name, value: r.contacts[i].id});
                }
            }
            c.set('v.contactsOptions',contactsOptions);
        });
    },
  onEdit: function (c, e, h) {
    var recordId = e.getSource().get('v.value');
    sessionStorage.setItem('retailDeliveryTicketId', recordId);
    h.redirect('/retaildeliveryticketd2d', true);
  },
  onCancel: function (c, e, h) {
    h.redirect('/retaildeliveryticketsd2d', true);
  }
})