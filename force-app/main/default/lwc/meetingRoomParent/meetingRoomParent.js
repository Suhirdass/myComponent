import { LightningElement,track } from 'lwc';

export default class MeetingRoomParent extends LightningElement {

    @track selectedMeetingRoom;

    meetingRoomsInfo = [
        {roomName:'A-01', roomCapacity:'12'},
        {roomName:'A-02', roomCapacity:'16'},
        {roomName:'A-03', roomCapacity:'12'},
        {roomName:'B-01', roomCapacity:'5'},
        {roomName:'B-02', roomCapacity:'8'},
        {roomName:'B-03', roomCapacity:'10'},
        {roomName:'C-01', roomCapacity:'20'}

    ];

    //event -- event attribute, from this attribute we can get detail property because it have all our payload data
    onTileSelectHandler(event){
      const meetingRoomInfo = event.detail;
      this.selectedMeetingRoom = meetingRoomInfo.roomName;
    }

    //second way to communicate Child To Parent by using constructor
    constructor(){
        super();
        //To define or attach the event handler by using template & addEvent listener method
        //1st Parameter - Event name
        //2nd Parameter - need to bind event handler (onTileSelectHandler) with the event by using bind method
        this.template.addEventListener('tileclick', this.onTileSelectHandler.bind(this));
    }
}