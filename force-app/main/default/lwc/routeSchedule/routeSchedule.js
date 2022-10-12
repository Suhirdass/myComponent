import { LightningElement, track, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import displayRSMTSM from '@salesforce/apex/DisplayRSMTSMController.displayRSMTSM';
import getRSMTSM from '@salesforce/apex/DisplayRSMTSMController.getRSMTSM';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';
import jQueryDataTablesZip from '@salesforce/resourceUrl/jQueryDataTablesZip';
import datatable from '@salesforce/resourceUrl/datatable';
import getActiveDrivers from '@salesforce/apex/DisplayRSMTSMController.getActiveDrivers';
import getActiveVehicles from '@salesforce/apex/DisplayRSMTSMController.getActiveVechile';
import updateShipManifestData from '@salesforce/apex/DisplayRSMTSMController.updateSMData';


export default class routeSchedule extends NavigationMixin(LightningElement) {
    @api isLoaded = false;
    @track emptychange = [];
    @track emptychangeTsm = [];
    @track setTSM = [];
    @track setRSM = [];
    @track setRSMTemp = [];
    @track setTSMTemp = [];
    @track dataRSM = [];
    @track dataTSM = [];
    @track filterTSM = [];
    @track filterRSM = [];
    @track dat = '';
    @track datTwo = '';
    @track isAscTSM = 'desc';
    @track isAscRSM = 'desc';
    @track isDataLoaded = false;
    @track isNoTSM;
    @track isNoRSM;
    @track options = [];
    isDataTableInit = false;
    /* rsm variable for filter*/
    @track i = 0;
    @track siteName = [];
    @track siteObj = {};
    @track shipDate = [];
    @track shipObj = {};
    @track driverName = [];
    @track driverObj = {};
    @track windowSE = [];
    @track windowSEObj = {};
    @track recDBA = [];
    @track recDBAObj = {};


    /*Tsm filter event variable*/
    @track filterSiteNameTsm = null;
    @track filterShipDateTsm = null;
    @track filterDriverNameTsm = null;
    @track filterWindowSETsm = null;
    @track filterSupDBATsm = null;

    /*Rsm filter event variable*/
    @track filterRecDBARsm = null;
    @track filterWindowSERsm = null;
    @track filterDriverNameRsm = null;
    @track filterShipDateRsm = null;
    @track filterSiteNameRsm = null;


    /* Tsm variable for filter*/
    @track siteNameTsm = [];
    @track siteObjTsm = {};
    @track shipDateTsm = [];
    @track shipObjTsm = {};
    @track driverNameTsm = [];
    @track driverObjTsm = {};
    @track windowSETsm = [];
    @track windowSEObjTsm = {};
    @track supDBATsm = [];
    @track supDBAObjTsm = {};


    /*check flag rsm or tsm*/
    @track isRsm = false;
    @track isTsm = false;

    @track page = 1;
    @track startingRecord = 1;
    @track endingRecord = 0;
    @track pageSize = 10;
    @track totalRecountCount = 0;
    @track totalPage = 0;

    @track pageTsm = 1;
    @track startingRecordTsm = 1;
    @track endingRecordTsm = 0;
    @track pageSizeTsm = 10;
    @track totalRecountCountTsm = 0;
    @track totalPageTsm = 0;

    @track strSearchProdName = '';

    @track driverName;
    @api recordId;
    @track setTSMsave = [];

    /*fetch array of value from drop down for tsm driver*/
    @track tsmDriverId;
    @track changedSmIdTsm;
    @track changedDataArrayTsm = [];
    @track newdriverObjTsm = {};
    @track smValueCheckTsm = '';

    /*fetch array of value from drop down for rsm driver*/
    @track rsmDriverId;
    @track changedSmIdRsm;
    @track changedDataArrayRsm = [];
    @track newdriverObjRsm = {};
    @track smValueCheckRsm = '';


    /*fetch array of value from drop down for rsm vehicle*/
    @track rsmVehicleId;
    @track changedSmIdvehicleRsm;
    @track changedDataArrayVehicleRsm = [];
    @track newvehicleObjRsm = {};
    @track smValueCheckvehicleRsm = '';

    /*fetch array of value from drop down for tsm driver*/
    @track tsmVehicleId;
    @track changedSmIdvehicleTsm;
    @track changedDataArrayVehicleTsm = [];
    @track newvehicleObjTsm = {};
    @track smValueCheckvehicleTsm = '';

    /**bind driver & vechile */
    @track bindDriver = [];
    @track bindVehicle = [];

    @track totalVehicleArray = [];
    @track totalDriverArray = [];

    @track totalSmData = [];
    @track totalSm = [];
    @track newSmObjData = {};


    @track totalSMRecord = [];
    @track totalSORecord = [];
    @track totalPORecord = [];

    @track isOpenModal = false;
    @track isOpenModalTsm = false;


    /*Rsm value update to existing list via soId*/
    onShipDateChangeRsm(event) {

        let id = event.target.dataset.name;
        var divblock = this.template.querySelector(`[data-id="${id}"]`);

        if (divblock) {
            this.template.querySelector(`[data-id="${id}"]`).classList.add('class1');
        }
        var newDate = new Date().toISOString().slice(0, 10);
        let foundelement = this.setRSM.find(ele => ele.smId == event.target.dataset.id);
        if(event.target.value == null){
            foundelement.shipDate = newDate; 
        }else{
            foundelement.shipDate = event.target.value;
        } 
        foundelement.isUpdated = true;
        this.setRSM = [...this.setRSM];

        console.log('tables : ', this.setRSM);


    }

    onDriverChangeRsm(event) {

        let id = event.target.dataset.name;
        var divblock = this.template.querySelector(`[data-id="${id}"]`);

        if (divblock) {
            this.template.querySelector(`[data-id="${id}"]`).classList.add('class1');
        }

        let foundelement = this.setRSM.find(ele => ele.smId == event.target.dataset.id);
        foundelement.driverId = event.target.value;
        foundelement.isUpdated = true;
        this.setRSM = [...this.setRSM];

        console.log('tables : ', this.setRSM);


    }

    onVehicleChangeRsm(event) {

        let id = event.target.dataset.name;
        var divblock = this.template.querySelector(`[data-id="${id}"]`);

        if (divblock) {
            this.template.querySelector(`[data-id="${id}"]`).classList.add('class1');
        }
        let foundelement = this.setRSM.find(ele => ele.smId == event.target.dataset.id);
        foundelement.vehicleId = event.target.value;
        foundelement.isUpdated = true;
        this.setRSM = [...this.setRSM];
        console.log('tables : ', this.setRSM);
    }

    onWindowEndDateRsm(event) {
        let id = event.target.dataset.name;
        var divblock = this.template.querySelector(`[data-id="${id}"]`);

        if (divblock) {
            this.template.querySelector(`[data-id="${id}"]`).classList.add('class1');
        }

        let foundelement = this.setRSM.find(ele => ele.smId == event.target.dataset.id);
        foundelement.windowEnd = event.target.value;
        foundelement.isUpdated = true;
        this.setRSM = [...this.setRSM];
        console.log('tables : ', this.setRSM);
    }

    onWindowStartDateRsm(event) {
        let id = event.target.dataset.name;
        var divblock = this.template.querySelector(`[data-id="${id}"]`);

        if (divblock) {
            this.template.querySelector(`[data-id="${id}"]`).classList.add('class1');
        }
        let foundelement = this.setRSM.find(ele => ele.smId == event.target.dataset.id);
        foundelement.windowStart = event.target.value;
        foundelement.isUpdated = true;
        this.setRSM = [...this.setRSM];
        console.log('tables : ', this.setRSM);
    }

    onMetrcChangeRsm(event) {
        let id = event.target.dataset.name;
        var divblock = this.template.querySelector(`[data-id="${id}"]`);

        if (divblock) {
            this.template.querySelector(`[data-id="${id}"]`).classList.add('class1');
        }
        let foundelement = this.setRSM.find(ele => ele.soId == event.target.dataset.id);
        foundelement.metrc = event.target.value;
        foundelement.isUpdated = true;
        this.setRSM = [...this.setRSM];
        console.log('tables : ', this.setRSM);
    }


    /*tsm value update to existing list via soId*/
 
    onShipDateChangTsm(event) {

        let id = event.target.dataset.name;
        var divblock = this.template.querySelector(`[data-class="${id}"]`);

        if (divblock) {
            this.template.querySelector(`[data-class="${id}"]`).classList.add('class1');
        }
        var newDate = new Date().toISOString().slice(0, 10);

        let foundelement = this.setTSM.find(ele => ele.poId == event.target.dataset.id);
        if(event.target.value == null){
            foundelement.shipDate = newDate; 
        }else{
            foundelement.shipDate = event.target.value;
        } 
        foundelement.isUpdated = true;
        this.setTSM = [...this.setTSM];
        console.log('tables : ', this.setTSM);
    }

    onDriverChangTsm(event) {
        console.log('tables1 : ', event.target.value);
        let id = event.target.dataset.name;
        var divblock = this.template.querySelector(`[data-class="${id}"]`);

        if (divblock) {
            this.template.querySelector(`[data-class="${id}"]`).classList.add('class1');
        }

        let foundelement = this.setTSM.find(ele => ele.poId == event.target.dataset.id);
        foundelement.driverId = event.target.value;
        foundelement.isUpdated = true;
        this.setTSM = [...this.setTSM];
        console.log('tables : ', this.setTSM);
        
    }

    onVechileChangeTsm(event) {
        let id = event.target.dataset.name;
        var divblock = this.template.querySelector(`[data-class="${id}"]`);

        if (divblock) {
            this.template.querySelector(`[data-class="${id}"]`).classList.add('class1');
        }

        let foundelement = this.setTSM.find(ele => ele.poId == event.target.dataset.id);
        foundelement.vehicleId = event.target.value;
        foundelement.isUpdated = true;
        this.setTSM = [...this.setTSM];
        console.log('tables : ', this.setTSM);
    }


    updateValueCheck() {
        const h = this;
        if (h.setRSM.length > 0) {
            let i = 0;
            for (i = 0; i < h.setRSM.length; i++) {
                if (h.setRSM[i].smId && (h.setRSM[i].isUpdated == true)) {
                    h.totalSMRecord.push(h.setRSM[i]);
                    h.totalSORecord.push(h.setRSM[i]);
                } else if (h.setRSM[i].isUpdated == true) {
                    h.totalSORecord.push(h.setRSM[i]);
                }
            }
        }


        if (h.setTSM.length > 0) {
            let i = 0;
            for (i = 0; i < h.setTSM.length; i++) {
                if (h.setTSM[i].smId && (h.setTSM[i].isUpdated == true)) {
                    h.totalSMRecord.push(h.setTSM[i]);
                } else if (h.setTSM[i].isUpdated == true) {
                    h.totalPORecord.push(h.setTSM[i]);
                }
            }
        }
    }


    updateShipManifestData(event) {
        const h = this;
        console.log('totalPORecord', h.totalPORecord);
        console.log('totalSMRecord', h.totalSMRecord);
        console.log('totalSORecord', h.totalSORecord);
        h.updateValueCheck();
        let stringifytotalSMRecord = JSON.stringify(h.totalSMRecord);
        let stringifytotalPORecord = JSON.stringify(h.totalPORecord);
        let stringifytotalSORecord = JSON.stringify(h.totalSORecord);

        if (h.totalSMRecord.length > 0 || h.totalPORecord.length > 0 || h.totalSORecord.length > 0) {
            h.isLoaded = !h.isLoaded;
            updateShipManifestData({ totalSMRecord: stringifytotalSMRecord, totalPORecord: stringifytotalPORecord, totalSORecord: stringifytotalSORecord })
                .then(r => {
                    const evt = new ShowToastEvent({
                        title: 'Success!',
                        message: 'Records updated successfully',
                        variant: 'success',
                        mode: 'dismissable'
                    });
                    this.dispatchEvent(evt);
                    h.isLoaded = true;
                    window.location.reload();

                })
                .catch(error => {

                    const evt = new ShowToastEvent({
                        title: 'Record Failed',
                        message: 'Error',
                        variant: 'error',
                        mode: 'dismissable'
                    });
                    this.dispatchEvent(evt);
                    console.log("getIds Error:", error);
                });
        } else {
            const evt = new ShowToastEvent({
                title: 'Warning!',
                message: 'No changes made in the records',
                variant: 'warning',
                mode: 'dismissable'
            });
            this.dispatchEvent(evt);

        }

    }

    handleSearch(event) {
        const h = this;
        let strSearchProdName = event.target.value;
        var setRSM = [];
        var tableRsm = h.dataRSM;
        tableRsm.find(function (element) {
            console.log('ele', element);
            if (element.siteName != undefined && element.siteName.toLowerCase().includes(strSearchProdName.toLowerCase())) {
                setRSM.push(element);
            } else if (element.driverId != undefined && element.driverName.toLowerCase().includes(strSearchProdName.toLowerCase())) {
                setRSM.push(element);
            }

        });
        console.log(setRSM.length);
        h.setRSM = setRSM;
        h.setRSMTemp = setRSM;
        h.startingRecord = 1;
        h.page = 1;
        h.totalRecountCount = h.setRSM.length;
        h.totalPage = Math.ceil(h.totalRecountCount / h.pageSize);
        h.setRSM = h.setRSM.slice(0, this.pageSize);
        h.endingRecord = h.pageSize;
        if (h.setRSM.length == 0) {
            h.isNoRSM = true;
        } else {
            h.isNoRSM = false;
        }
    }

    handleSearchTSM(event) {
        const h = this;
        let strSearchProdName = event.target.value;
        var setTSM = [];
        var tableTsm = h.dataTSM;
        tableTsm.find(function (element) {
            if (element.siteName != undefined && element.siteName.toLowerCase().includes(strSearchProdName.toLowerCase())) {
                setTSM.push(element);
            } else if (element.driverName != undefined && element.driverName.toLowerCase().includes(strSearchProdName.toLowerCase())) {
                setTSM.push(element);
            }
        });
        console.log(setTSM.length);
        h.setTSM = setTSM;
        h.setTSMTemp = setTSM;
        h.startingRecordTsm = 1;
        h.pageTsm = 1;
        h.totalRecountCountTsm = h.setTSM.length;
        h.totalPageTsm = Math.ceil(h.totalRecountCountTsm / h.pageSizeTsm);
        h.setTSM = h.setTSM.slice(0, this.pageSizeTsm);
        h.endingRecordTsm = h.pageSizeTsm;
        if (h.setTSM.length == 0) {
            h.isNoTSM = true;
        } else {
            h.isNoTSM = false;
        }
    }

    connectedCallback() {
        this.getRecords();
    }

    renderedCallback() {
        const h = this;
        /*if(this.isDataTableInit){
            return;            
        }
        this.isDataTableInit = true;*/
        Promise.all([
            loadStyle(this, jQueryDataTablesZip + '/css/jquery.dataTables.css'),
            loadScript(this, datatable + '/js/jquery.min.js'),
            loadScript(this, datatable + '/js/jquery.dataTables.min.js')
        ])
            .then(() => {
                /*var table = this.template.querySelectorAll('table.myDataTable');
                console.log('tables : ',table.length);
                
                table.forEach((item) => {
                    var dtable = $(item).DataTable();
                    dtable.destroy();
                    $(item).dataTable();
                });*/
            })
            .catch(error => {
                console.log(error);
            });
    }

    previousHandler() {
        const h = this;
        if (h.page > 1) {
            h.page = h.page - 1; //decrease page by 1
            h.displayRecordPerPage(h.page);
        }
    }

    firstHandlerTsm() {
        const h = this;
        h.startingRecordTsm = 1;
        h.pageTsm = 1;
        h.totalRecountCountTsm = h.setTSMTemp.length;
        h.totalPageTsm = Math.ceil(h.totalRecountCountTsm / h.pageSizeTsm);
        h.setTSM = h.setTSMTemp.slice(0, h.pageSizeTsm);
        h.endingRecordTsm = h.pageSizeTsm;
        if (h.setTSM.length == 0) {
            h.isNoTSM = true;
        } else {
            h.isNoTSM = false;
        }
    }

    firstHandler() {
        const h = this;
        h.startingRecord = 1;
        h.page = 1;
        h.totalRecountCount = h.setRSMTemp.length;
        h.totalPage = Math.ceil(h.totalRecountCount / h.pageSize);
        h.setRSM = h.setRSMTemp.slice(0, h.pageSize);
        h.endingRecord = h.pageSize;
        if (h.setRSM.length == 0) {
            h.isNoRSM = true;
        } else {
            h.isNoRSM = false;
        }
    }

    lastHandler() {
        const h = this;
        h.totalRecountCount = h.setRSMTemp.length;
        h.totalPage = Math.ceil(h.totalRecountCount / h.pageSize);
        h.page = h.totalPage;
        h.startingRecord = (h.pageSize * (h.totalPage - 1)) + 1;
        h.setRSM = h.setRSMTemp.slice(h.startingRecord - 1, h.totalRecountCount);
        h.endingRecord = h.totalRecountCount;
        if (h.setRSM.length == 0) {
            h.isNoRSM = true;
        } else {
            h.isNoRSM = false;
        }
    }

    lastHandlerTsm() {
        const h = this;
        h.totalRecountCountTsm = h.setTSMTemp.length;
        h.totalPageTsm = Math.ceil(h.totalRecountCountTsm / h.pageSizeTsm);
        h.pageTsm = h.totalPageTsm;
        h.startingRecordTsm = (h.pageSizeTsm * (h.totalPageTsm - 1)) + 1;
        h.setTSM = h.setTSMTemp.slice(h.startingRecordTsm - 1, h.totalRecountCountTsm);
        h.endingRecordTsm = h.totalRecountCountTsm;
        if (h.setTSM.length == 0) {
            h.isNoTSM = true;
        } else {
            h.isNoTSM = false;
        }
    }

    previousHandlerTsm() {
        const h = this;
        if (h.pageTsm > 1) {
            h.pageTsm = h.pageTsm - 1; //decrease page by 1
            h.displayRecordPerPageTsm(h.pageTsm);
        }
    }
    //this method handles the Next button with the help of dispatchEvent
    nextHandler() {

        const h = this;
        console.log('setrsm', h.setRSM);
        if ((h.page < h.totalPage) && h.page !== h.totalPage) {
            h.page = h.page + 1; //increase page by 1
            h.displayRecordPerPage(h.page);
        }
    }

    handleCloseModal() {
        this.isOpenModal = false;
    }

    handleOpenModal(event) {
        const h = this;
        h.updateValueCheck();
        if (h.totalSMRecord.length > 0 || h.totalPORecord.length > 0 || h.totalSORecord.length > 0) {
            this.isOpenModal = true;
        }
        else {
            if (event.target.dataset.id == 'next') {
                h.nextHandler();
                this.isOpenModal = false;
            }
            if (event.target.dataset.id == 'first') {
                h.firstHandler();
                this.isOpenModal = false;
            }
            if (event.target.dataset.id == 'previous') {
                h.previousHandler();
                this.isOpenModal = false;
            }
            if (event.target.dataset.id == 'last') {
                h.lastHandler();
                this.isOpenModal = false;
            }
        }

    }

    navigationHandler() {
        const h = this;
        h.totalSMRecord = [];
        h.totalPORecord = [];
        h.totalSORecord = [];

        h.setRSM.forEach(function (item) {
            return item.isUpdated = false;
        });

        h.setTSM.forEach(function (item) {
            return item.isUpdated = false;
        });

        if ((h.page < h.totalPage) && h.page !== h.totalPage) {
            h.nextHandler();
            this.isOpenModal = false;
        } else if (h.page > 1) {
            h.previousHandler();
            this.isOpenModal = false;
        } else if (h.page == 1) {
            h.firstHandler();
            this.isOpenModal = false;
        } else {
            h.lastHandler();
            this.isOpenModal = false;
        }

    }


    navigationHandlerTsm() {
        const h = this;
        h.totalSMRecord = [];
        h.totalPORecord = [];
        h.totalSORecord = [];

        h.setRSM.forEach(function (item) {
            return item.isUpdated = false;
        });

        h.setTSM.forEach(function (item) {
            return item.isUpdated = false;
        });

        if ((h.pageTsm < h.totalPageTsm) && h.pageTsm !== h.totalPageTsm) {
            h.nextHandlerTsm();
            this.isOpenModalTsm = false;
        } else if (h.pageTsm > 1) {
            h.previousHandlerTsm();
            this.isOpenModalTsm = false;
        } else if (h.pageTsm == 1) {
            h.firstHandlerTsm();
            this.isOpenModalTsm = false;
        } else {
            h.lastHandlerTsm();
            this.isOpenModalTsm = false;
        }

    }

    handleOpenModalTsm(event) {
        const h = this;
        h.updateValueCheck();
        if (h.totalSMRecord.length > 0 || h.totalPORecord.length > 0 || h.totalSORecord.length > 0) {
            this.isOpenModalTsm = true;
        }
        else {
            if (event.target.dataset.id == 'nextTsm') {
                h.nextHandlerTsm();
                this.isOpenModalTsm = false;
            }
            if (event.target.dataset.id == 'firstTsm') {
                h.firstHandlerTsm();
                this.isOpenModalTsm = false;
            }
            if (event.target.dataset.id == 'previousTsm') {
                h.previousHandlerTsm();
                this.isOpenModalTsm = false;
            }
            if (event.target.dataset.id == 'lastTsm') {
                h.lastHandlerTsm();
                this.isOpenModalTsm = false;
            }
        }

    }

    handleCloseModalTsm() {
        this.isOpenModalTsm = false;
    }

    nextHandlerTsm() {
        const h = this;
        if ((h.pageTsm < h.totalPageTsm) && h.pageTsm !== h.totalPageTsm) {
            h.pageTsm = h.pageTsm + 1; //increase page by 1
            h.displayRecordPerPageTsm(h.pageTsm);
        }
    }

    displayRecordPerPageTsm(page) {
        const h = this;
        h.startingRecordTsm = ((page - 1) * h.pageSizeTsm);
        h.endingRecordTsm = (h.pageSizeTsm * page);
        h.endingRecordTsm =
            (h.endingRecordTsm > h.totalRecountCountTsm) ? h.totalRecountCountTsm : h.endingRecordTsm;
        h.setTSM = h.setTSMTemp.slice(h.startingRecordTsm, h.endingRecordTsm);
        h.startingRecordTsm = h.startingRecordTsm + 1;
        if (h.setTSM.length == 0) {
            h.isNoTSM = true;
        } else {
            h.isNoTSM = false;
        }
    }

    displayRecordPerPage(page) {
        const h = this;
        h.startingRecord = ((page - 1) * h.pageSize);
        h.endingRecord = (h.pageSize * page);
        h.endingRecord =
            (h.endingRecord > h.totalRecountCount) ? h.totalRecountCount : h.endingRecord;
        h.setRSM = h.setRSMTemp.slice(h.startingRecord, h.endingRecord);
        h.startingRecord = h.startingRecord + 1;
        if (h.setRSM.length == 0) {
            h.isNoRSM = true;
        } else {
            h.isNoRSM = false;
        }
    }

    handleTsmValueChange(event) {
        const h = this;
        h.valueTsm = event.detail.value;
        h.pageSizeTsm = h.valueTsm;
        h.totalRecountCountTsm = h.setTSMTemp.length;
        h.totalPageTsm = Math.ceil(h.totalRecountCountTsm / h.pageSizeTsm);
        h.setTSM = h.setTSMTemp.slice(0, this.pageSizeTsm);
        h.endingRecordTsm = h.pageSizeTsm;
        if (h.setTSM.length == 0) {
            h.isNoTSM = true;
        } else {
            h.isNoTSM = false;
        }
    }

    handleValueChange(event) {
        const h = this;
        h.valueRsm = event.detail.value;
        h.pageSize = h.valueRsm;
        h.totalRecountCount = h.setRSMTemp.length;
        h.totalPage = Math.ceil(h.totalRecountCount / h.pageSize);
        h.setRSM = h.setRSMTemp.slice(0, this.pageSize);
        h.endingRecord = h.pageSize;
        if (h.setRSM.length == 0) {
            h.isNoRSM = true;
        } else {
            h.isNoRSM = false;
        }
    }


    getRecords() {
        const h = this;
        let picklistOptions = [{ label: '10', value: '10' }, { label: '25', value: '25' },
        { label: '50', value: '50' }, { label: '100', value: '100' }];
        h.options = picklistOptions;
        h.valueRsm = '10';
        h.valueTsm = '10';
        h.siteNameTsm = [];
        h.shipDateTsm = [];
        h.driverNameTsm = [];
        h.windowSETsm = [];
        h.supDBATsm = [];
        h.siteName = [];
        h.shipDate = [];
        h.driverName = [];
        h.windowSE = [];
        h.recDBA = [];
        this.isLoaded = !this.isLoaded;

        displayRSMTSM({})
            .then(r => {
                this.isLoaded = true;
                console.log('setRsmList == ', r.data.setRsmList);
                console.log('setTsmList == ', r.data.setTsmList);
                h.emptychange = r.data.setRsmList;
                h.emptychangeTsm = r.data.setTsmList;

                h.emptychange = h.emptychange.map(item => {

                    if (item.status == 'Shipment Complete') {
                        item.StatusCheck = true;
                    } else {
                        item.StatusCheck = false;
                    }

                    if (item.smId) {
                        item.isEnabled = false;
                    } else {
                        item.isEnabled = true;
                    }
                    if (item.soId) {
                        item.ishelpEnabled = true;
                    } else {
                        item.ishelpEnabled = true;
                    }

                    if(item.smName && item.status){
                        item.concatValue = item.smName + ' - ' + item.recordTypeName + ' - ' + item.status;
                    }

                    if (item.windowStart == 0) {
                        item.windowStart = this.convertSectoTime(86400);
                        //new Date(item.windowStart * 1000).toISOString().substr(11, 8);
                    }
                    else {
                        if (item.windowStart) {
                            var timestamp = item.windowStart / 1000;
                            item.windowStart = this.convertSectoTime(timestamp);
                        }
                    }

                    if (item.windowEnd == 0) {
                        item.windowEnd = this.convertSectoTime(86400);
                        //new Date(item.windowStart * 1000).toISOString().substr(11, 8);
                    }
                    else {
                        if (item.windowEnd) {
                            var timestamp = item.windowEnd / 1000;
                            item.windowEnd = this.convertSectoTime(timestamp);
                        }
                    }

                    if (item.shipDate) {
                        //var date = new Date(item.shipDate);
                        //item.shipDate = this.convertDate(date);
                        item.shipDate = item.shipDate;
                    }

                    if(item.smId || item.soId || item.siteId){
                        if(item.smId && item.baseUrl){
                            item.smUrl = item.baseUrl+ '/lightning/r/Shipping_Manifest__c/'+ item.smId +'/view';
                        }
                        if(item.soId && item.baseUrl){
                            item.soUrl = item.baseUrl+ '/lightning/r/Sales_Order__c/'+ item.soId +'/view';
                        }
                        if(item.siteId && item.baseUrl){
                            item.sUrl = item.baseUrl+ '/lightning/r/Site__c/'+ item.siteId +'/view';
                        }
                       
                    }

                    return item;

                });

                h.emptychangeTsm = h.emptychangeTsm.map(item => {

                    if (item.status == 'Shipment Complete') {
                        item.StatusCheck = true;
                    } else {
                        item.StatusCheck = false;
                    }

                    if (item.shipDate) {
                        //var date = new Date(item.shipDate);
                        //item.shipDate = this.convertDate(date);
                        item.shipDate = item.shipDate;
                    }

                    if(item.smId || item.soId || item.siteId){
                        if(item.smId && item.baseUrl){
                            item.smUrl = item.baseUrl+ '/lightning/r/Shipping_Manifest__c/'+ item.smId +'/view';
                        }
                        if(item.poId && item.baseUrl){
                            item.poUrl = item.baseUrl+ '/lightning/r/Purchase_Order__c/'+ item.poId +'/view';
                        }
                        if(item.siteId && item.baseUrl){
                            item.sUrl = item.baseUrl+ '/lightning/r/Site__c/'+ item.siteId +'/view';
                        }
                       
                    }

                    return item;

                });

                h.setTSM = h.emptychangeTsm;
                h.setRSM = h.emptychange;
                h.setRSMTemp = h.emptychange;
                h.setTSMTemp = h.emptychangeTsm;
                h.dataRSM = h.emptychange;
                h.dataTSM = h.emptychangeTsm;
                h.dat = r.data.dat;
                h.datTwo = r.data.datTwo;
                h.isDataLoaded = true;


                h.totalRecountCount = h.setRSM.length;
                h.totalPage = Math.ceil(h.totalRecountCount / h.pageSize);
                h.setRSM = h.setRSM.slice(0, this.pageSize);
                h.endingRecord = h.pageSize;
                if (h.setRSM.length == 0) {
                    h.isNoRSM = true;
                } else {
                    h.isNoRSM = false;
                }

                h.totalRecountCountTsm = h.setTSM.length;
                h.totalPageTsm = Math.ceil(h.totalRecountCountTsm / h.pageSizeTsm);
                h.setTSM = h.setTSM.slice(0, this.pageSizeTsm);
                h.endingRecordTsm = h.pageSizeTsm;
                if (h.setTSM.length == 0) {
                    h.isNoTSM = true;
                } else {
                    h.isNoTSM = false;
                }

                h.isSiteTSM = false;
                h.isDateTSM = true;
                h.isStatusTSM = false;
                h.isDriverTSM = false;
                h.isSupNameTSM = false;
                h.isWindowSETSM = false;

                h.isSiteRSM = false;
                h.isDateRSM = true;
                h.isStatusRSM = false;
                h.isDriverRSM = false;
                h.isSOrderRSM = false;
                h.isRecNameRSM = false;
                h.isSOrderRSM = false;
            })
            .catch(error => {
                console.log("getIds Error:", error);
            });
        this.getDrivers();
        this.getVehicles();
    }

    handleFromDateCahngeEvent(event) {
        const h = this;
        h.dat = event.target.value;
    }
    handleToDateCahngeEvent(event) {
        const h = this;
        h.datTwo = event.target.value;
    }


    applyDataTable(event) {
        try {
            console.log('applyDataTable');
            var table = this.template.querySelectorAll('table.myDataTable');
            console.log('tables : ', table.length);
            /*var dtable = $(table).DataTable();
            console.log('dataTable - ',dtable);
            if(dtable) {
                dtable.destroy();
            }*/
            table.forEach((item) => {
                //var dtable = $(item).DataTable();
                // dtable.destroy();
                $(item).dataTable();
            });

        } catch (error) {
            console.log('Error = ', error);
        }

    }

    searchDate(event) {
        console.log('HandleClick 1');
        const h = this;
        var fromDate = new Date(h.dat); //yyyy-mm-dd  
        var toDate = new Date(h.datTwo); //yyyy-mm-dd  
        if (fromDate > toDate) {
            const evt = new ShowToastEvent({
                title: 'ERROR',
                message: 'Invalid Date Range',
                variant: 'error',
                mode: 'dismissable'
            });
            this.dispatchEvent(evt);

        } else {
            this.isLoaded = !this.isLoaded;
            getRSMTSM({ fromDate: h.dat, toDate: h.datTwo })
                .then(r => {
                    //console.log('rsm1handleClick == ', r.data.setRSM);
                    console.log('r.data.setRsmList== ', r.data.setRsmList);
                    console.log('r.data.setTsmList== ', r.data.setTsmList);
                    this.isLoaded = true;
                    //h.emptychange = r.data.setRSM;
                    h.emptychange = r.data.setRsmList;
                    // h.emptychangeTsm = r.data.setTSM;

                    h.emptychangeTsm = r.data.setTsmList;

                    h.emptychange = h.emptychange.map(item => {


                        if (item.status == 'Shipment Complete') {
                            item.StatusCheck = true;

                        } else {
                            item.StatusCheck = false;
                        }

                        if (item.smId) {
                            item.isEnabled = false;
                        } else {
                            item.isEnabled = true;
                        }
                        
                        if (item.soId) {
                            item.ishelpEnabled = false;
                        } else {
                            item.ishelpEnabled = true;
                        }

                        if(item.smName && item.status){
                            item.concatValue = item.smName + ' - ' + item.recordTypeName + ' - ' + item.status;
                        }
    

                        if (item.windowStart == 0) {
                            item.windowStart = this.convertSectoTime(86400);
                        }
                        else {
                            if (item.windowStart) {
                                var timestamp = item.windowStart / 1000;
                                item.windowStart = this.convertSectoTime(timestamp);
                            }
                        }

                        if (item.windowEnd == 0) {
                            item.windowEnd = this.convertSectoTime(86400);
                        }
                        else {
                            if (item.windowEnd) {
                                var timestamp = item.windowEnd / 1000;
                                item.windowEnd = this.convertSectoTime(timestamp);
                            }
                        }

                        if (item.shipDate) {
                            //var date = new Date(item.shipDate);
                            //item.shipDate = this.convertDate(date);
                            item.shipDate = item.shipDate;
                        }
                        if(item.smId || item.soId || item.siteId){
                            if(item.smId && item.baseUrl){
                                item.smUrl = item.baseUrl+ '/lightning/r/Shipping_Manifest__c/'+ item.smId +'/view';
                            }
                            if(item.soId && item.baseUrl){
                                item.soUrl = item.baseUrl+ '/lightning/r/Sales_Order__c/'+ item.soId +'/view';
                            }
                            if(item.siteId && item.baseUrl){
                                item.sUrl = item.baseUrl+ '/lightning/r/Site__c/'+ item.siteId +'/view';
                            }
                           
                        }
                        return item;

                    });

                    h.emptychangeTsm = h.emptychangeTsm.map(item => {

                        if (item.status == 'Shipment Complete') {
                            item.StatusCheck = true;
                        } else {
                            item.StatusCheck = false;
                        }
                        if(item.driverName=='None')
                        {
                            item.driverName = ' ';

                        }else{
                            item.driverId = item.driverId;
                        }

                        /*convert utc*/

                        if (item.shipDate) {
                            //var date = new Date(item.shipDate);
                            //item.shipDate = this.convertDate(date);
                            item.shipDate = item.shipDate;
                        }

                        if(item.smId || item.soId || item.siteId){
                            if(item.smId && item.baseUrl){
                                item.smUrl = item.baseUrl+ '/lightning/r/Shipping_Manifest__c/'+ item.smId +'/view';
                            }
                            if(item.poId && item.baseUrl){
                                item.poUrl = item.baseUrl+ '/lightning/r/Purchase_Order__c/'+ item.poId +'/view';
                            }
                            if(item.siteId && item.baseUrl){
                                item.sUrl = item.baseUrl+ '/lightning/r/Site__c/'+ item.siteId +'/view';
                            }
                           
                        }

                        return item;

                    });

                    h.setTSM = h.emptychangeTsm;
                    h.setRSM = h.emptychange;
                    h.setRSMTemp = h.emptychange;
                    h.setTSMTemp = h.emptychangeTsm;
                    h.dataRSM = h.emptychange;
                    h.dataTSM = h.emptychangeTsm;
                    h.dat = r.data.dat;
                    h.datTwo = r.data.datTwo;
                    console.log('r Data == ', h.setRSMTemp);


                    h.totalRecountCount = h.setRSM.length;
                    h.totalPage = Math.ceil(h.totalRecountCount / h.pageSize);
                    h.setRSM = h.setRSM.slice(0, this.pageSize);
                    h.endingRecord = h.pageSize;
                    if (h.setRSM.length == 0) {
                        h.isNoRSM = true;
                    } else {
                        h.isNoRSM = false;
                    }


                    h.totalRecountCountTsm = h.setTSM.length;
                    h.totalPageTsm = Math.ceil(h.totalRecountCountTsm / h.pageSizeTsm);
                    h.setTSM = h.setTSM.slice(0, this.pageSizeTsm);
                    h.endingRecordTsm = h.pageSizeTsm;
                    if (h.setTSM.length == 0) {
                        h.isNoTSM = true;
                    } else {
                        h.isNoTSM = false;
                    }

                })
                .catch(error => {
                    console.log("getIds Error:", error);
                });

        }


    }

    /*navigateToRecordView(event) {
        var recId = event.target.dataset.id;
        var objName = event.target.dataset.name;
      
        if(event.button == 0){
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: recId,
                    objectApiName: objName, // objectApiName is optional
                    actionName: 'view'
                }
            });

        }
        
    }
        
        navigateToRecordView1(event){
            var recId = event.target.dataset.id;
            var objName = event.target.dataset.name;
            event.stopPropagation();
            this[NavigationMixin.GenerateUrl]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: recId,
                    objectApiName: objName,
                    actionName: 'view'
                }
            }).then(url => { window.open(url) });
        

        /*event.stopPropagation();

    // Navigate to the Contact object's Recent list view.
    this[NavigationMixin.GenerateUrl]({
        type: 'standard__recordPage',
        attributes: {
            recordId: recId,
            objectApiName: objName,
            actionName: 'view'
        },
        /*state: { 
            fv0: this.account.data.fields.Id.value,
            fv1: event.target.dataset.id
        } 
    }).then(url => { window.open(url) });

    console.log('event',event.button);
    }*/




    navigateToShortView(event) {
        var shortField = event.target.dataset.id;
        const h = this;

        if (shortField == 'siteName') {
            h.isSiteTSM = true; h.isDateTSM = false;
            h.isStatusTSM = false; h.isDriverTSM = false;
        } else if (shortField == 'shipDate') {
            h.isSiteTSM = false; h.isDateTSM = true;
            h.isStatusTSM = false; h.isDriverTSM = false;
        } else if (shortField == 'status') {
            h.isSiteTSM = false; h.isDateTSM = false;
            h.isStatusTSM = true; h.isDriverTSM = false;
        } else if (shortField == 'driverName') {
            h.isSiteTSM = false; h.isDateTSM = false;
            h.isStatusTSM = false; h.isDriverTSM = true;

        }

        if (h.isAscTSM == 'desc') {
            h.isAscTSM = 'asc';
            h.ascTsm = true;
        } else {
            h.isAscTSM = 'desc';
            h.ascTsm = false;
        }

        h.emptychangeTsm = h.emptychangeTsm.sort(this.compareValues(shortField, h.isAscTSM));

        h.emptychangeTsm = h.emptychangeTsm.map(item => {
            if (item.status == 'Shipment Complete') {
                item.StatusCheck = true;
            } else {
                item.StatusCheck = false;
            }

            /*convert utc*/

            // if (item.tsm.Planned_Ship_Transfer_Date__c) {
            //     var date = new Date(item.tsm.Planned_Ship_Transfer_Date__c);
            //     item.tsm.Planned_Ship_Transfer_Date__c = this.convertDate(date);
            // }

            return item;

        });

        h.setTSM = h.emptychangeTsm;
        h.setTSMTemp = h.emptychangeTsm;
        h.dataTSM = h.emptychangeTsm;
        h.siteNameTsm = [];
        h.shipDateTsm = [];
        h.driverNameTsm = [];
        h.windowSETsm = [];
        h.supDBATsm = [];


        h.startingRecordTsm = 1;
        h.pageTsm = 1;

        h.totalRecountCountTsm = h.setTSM.length;
        h.totalPageTsm = Math.ceil(h.totalRecountCountTsm / h.pageSizeTsm);
        h.setTSM = h.setTSM.slice(0, this.pageSizeTsm);
        h.endingRecordTsm = h.pageSizeTsm;
        if (h.setTSM.length == 0) {
            h.isNoTSM = true;
        } else {
            h.isNoTSM = false;
        }

    }

    navigateToShortOutboundView(event) {
        var shortField = event.target.dataset.id;
        console.log('shortField', shortField);
        const h = this;

        console.log('h.setRSM', h.setRSM);

        if (shortField == 'siteName') {
            h.isSiteRSM = true; h.isDateRSM = false;
            h.isStatusRSM = false; h.isDriverRSM = false;
            h.isRecNameRSM = false; h.isSOrderRSM = false;
        } else if (shortField == 'shipDate') {
            h.isSiteRSM = false; h.isDateRSM = true;
            h.isStatusRSM = false; h.isDriverRSM = false;
            h.isRecNameRSM = false; h.isSOrderRSM = false;
        } else if (shortField == 'status') {
            h.isSiteRSM = false; h.isDateRSM = false;
            h.isStatusRSM = true; h.isDriverRSM = false;
            h.isRecNameRSM = false; h.isSOrderRSM = false;
        } else if (shortField == 'driverName') {
            h.isSiteRSM = false; h.isDateRSM = false;
            h.isStatusRSM = false; h.isDriverRSM = true;
            h.isRecNameRSM = false; h.isSOrderRSM = false;
        } else if (shortField == 'recieverName') {
            h.isSiteRSM = false; h.isDateRSM = false;
            h.isStatusRSM = false; h.isDriverRSM = false;
            h.isRecNameRSM = true; h.isSOrderRSM = false;
        } else if (shortField == 'soName') {
            h.isSiteRSM = false; h.isDateRSM = false;
            h.isStatusRSM = false; h.isDriverRSM = false;
            h.isRecNameRSM = false; h.isSOrderRSM = true;
        }

        if (h.isAscRSM == 'desc') {
            h.isAscRSM = 'asc';
            h.ascRsm = true;
        } else {
            h.isAscRSM = 'desc';
            h.ascRsm = false;
        }

        h.emptychange = h.emptychange.sort(this.compareValues(shortField, h.isAscRSM));

        console.log('h.emptychange')

        h.emptychange = h.emptychange.map(item => {

            if (item.status == 'Shipment Complete') {
                item.StatusCheck = true;
            } else {
                item.StatusCheck = false;
            }

            /*   if (item.windowStart != null) {
                   item.windowStart = new Date(item.windowStart * 1000).toISOString().substr(11, 8);
               }
               if (item.windowEnd  != null) {
                   item.windowEnd = new Date(item.windowEnd * 1000).toISOString().substr(11, 8);
               }*/

            return item;

        });

        h.setRSM = h.emptychange;
        h.setRSMTemp = h.emptychange;
        h.dataRSM = h.emptychange;
        h.siteName = [];
        h.shipDate = [];
        h.driverName = [];
        h.windowSE = [];
        h.recDBA = [];



        h.startingRecord = 1;
        h.page = 1;


        h.totalRecountCount = h.setRSM.length;
        h.totalPage = Math.ceil(h.totalRecountCount / h.pageSize);
        h.setRSM = h.setRSM.slice(0, this.pageSize);
        h.endingRecord = h.pageSize;
        if (h.setRSM.length == 0) {
            h.isNoRSM = true;
        } else {
            h.isNoRSM = false;
        }

    }

    compareValues(key, order = 'asc') {
        return function innerSort(a, b) {
            if (!a.hasOwnProperty(key) || !b.hasOwnProperty(key)) {
                // property doesn't exist on either object
                return 0;
            }

            const varA = (typeof a[key] === 'string')
                ? a[key].toUpperCase() : a[key];
            const varB = (typeof b[key] === 'string')
                ? b[key].toUpperCase() : b[key];

            let comparison = 0;
            if (varA > varB) {
                comparison = 1;
            } else if (varA < varB) {
                comparison = -1;
            }
            return (
                (order === 'desc') ? (comparison * -1) : comparison
            );
        };
    }


    globalReset(event) {
        const h = this;
        h.template.querySelectorAll(".filterTsm").forEach(each => {
            each.value = undefined;
        });
        h.template.querySelectorAll(".filterRsm").forEach(each => {
            each.value = undefined;
        });
        h.startingRecord = 1;
        h.page = 1;

        h.getRecords();

    }

    getDrivers() {
        getActiveDrivers({})
            .then(r => {
                let i = 0;
                this.bindDriverObj = {};
                this.bindDriverObj = { label: 'None', value: '' }
                this.bindDriver.push(this.bindDriverObj);
                for (i = 0; i < r.data.activeDrivers.length; i++) {
                    this.bindDriverObj = { label: r.data.activeDrivers[i].Name, value: r.data.activeDrivers[i].Id }
                    this.bindDriver.push(this.bindDriverObj);
                    
                }
                console.log('bind driver for',this.bindDriver);
               
                    this.bindDriver = Array.from(new Set(this.bindDriver.map(JSON.stringify))).map(JSON.parse);
                console.log('bind driver',this.bindDriver);

            })
            .catch(error => {
                console.log("getIds Error:", error);
            });
    }

    getVehicles() {
        getActiveVehicles({})
            .then(r => {

                console.log('active vehicle',r.data.activeVehicles);
                let i = 0;
                this.bindVehicleObj = {};
                this.bindVehicleObj = { label: 'None', value: '' }
                this.bindVehicle.push(this.bindVehicleObj);
                for (i = 0; i < r.data.activeVehicles.length; i++) {

                   
                    if(r.data.activeVehicles[i].Refrigerated__c == true){
                        this.bindVehicleObj = { label: r.data.activeVehicles[i].Name + ' (Refrigerated)', value: r.data.activeVehicles[i].Id }
                    }else{
                        this.bindVehicleObj = { label: r.data.activeVehicles[i].Name , value: r.data.activeVehicles[i].Id } 
                    }
                   
                   
                    //this.bindVehicleObj = { vehicleName: r.data.activeVehicles[i].Name, vehicleId: r.data.activeVehicles[i].Id }
                    this.bindVehicle.push(this.bindVehicleObj);
                    this.bindVehicle = Array.from(new Set(this.bindVehicle.map(JSON.stringify))).map(JSON.parse);
                }
               
            })
            .catch(error => {
                console.log("getIds Error:", error);
            });
    }

    convertDate(date) {
    console.log('date', date);
        var utc = new Date(date).toISOString().slice(0, 10);
        console.log('utc', utc);
        var convertdate = utc.split('-');
        var splitMonth = '';
        var splitDate = '';
        var monthSplit = convertdate[1].split('0');
        var dateSplit = convertdate[2].split('0');
        if (monthSplit[0] == '') {
            splitMonth = monthSplit[1];
        } else {
            splitMonth = convertdate[1];
        }
        if (dateSplit[0] == '') {
            splitDate = dateSplit[1];
        } else {
            splitDate = convertdate[2];
        }

         var formattedDate = convertdate[0] + '/'+splitDate + '/' + splitMonth;

        //var formattedDate = splitMonth + '/' + splitDate + '/' + convertdate[0];
        //var formattedDate =  convertdate[0] +  '-'+ splitMonth + '-' + splitDate;
        return formattedDate;
    }

    convertSectoTime(time) {
        var timestamp = time; //86400;
        var hours = Math.floor(timestamp / 60 / 60);
        var minutes = Math.floor(timestamp / 60) - (hours * 60);
        var seconds = timestamp % 60;
        var formatted = hours.toString().padStart(2, '0') + ':' + minutes.toString().padStart(2, '0') + ':' + seconds.toString().padStart(2, '0');
        return formatted;
    }

    formatDate(date) {
        var d = new Date(date),
            month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear();
    
        if (month.length < 2) 
            month = '0' + month;
        if (day.length < 2) 
            day = '0' + day;
    
        return [year, month, day].join('-');
    }

}