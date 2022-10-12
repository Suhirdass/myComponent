({
  showPopup: function (c) {
    var h = this;
    var isDataLoaded = c.get("v.isDataLoaded");
    if (isDataLoaded) {
      window.setTimeout($A.getCallback(function () {
        Swal.fire({
          title: c.get('v.recordName'),
          text: ' Approve RMA. Are you sure ?',
          type: '',
          showCancelButton: true,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#6b6161',
          confirmButtonText: 'Yes',
          cancelButtonText: 'No'
        }).then((result) => {
          if (result.value) {
            h.approveRMA(c);
          } else {
            $A.get("e.force:closeQuickAction").fire();
          }
        });
      }), 10);
    } else {
      window.setTimeout($A.getCallback(function () {
        h.showPopup(c);
      }), 100);
    }
  },
  approveRMA: function (c) {
    var h = this;
    h.request(c, 'approveRMAAndCreateOpp', { recordId: c.get("v.recordId") }, function (r) {
      h.success({ message: 'RMA Approved successfully.' });
      var navEvt = $A.get("e.force:navigateToSObject");
      navEvt.setParams({
        "recordId": c.get("v.recordId")
      });
      navEvt.fire();
    }, {
      done: function () {
        $A.get("e.force:closeQuickAction").fire();
      }
      });
  }
})