({
    navigate: function (c, e, h) {
        try{
             console.log("navigate");
        console.log('Menu:',e.currentTarget.datase.id);
        }catch(err){
            console.log("Error:",err);
        }
       
        //h.navigate(c, e);
    }
})