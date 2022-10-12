public class fromJSON {
public cls_Route[] Route;
	class cls_Route {
		public String Name;	//2089-3
		public String RouteDate;	//
		public String RouteStartTime;	//
		public String RouteEndTime;	//
		public String SiteName;	//
		public String Driver;	//
		public String Vehicle;	//
		public String Status;	//
		public cls_Records[] Records;
	}
	class cls_Records {
	//	public cls_Id[] Id;
	//	public cls_Name[] Name;
	//	public cls_TimeWindow[] TimeWindow;
		public Integer SeqNo;	//1
		//public cls_PlannedArrivalTime[] PlannedArrivalTime;
		public String PlannedDepartureTime;	//8:30
		public Integer VehicleId;	//0
	}
	
	public static fromJSON parse(String json){
		return (fromJSON) System.JSON.deserialize(json, fromJSON.class);
       
	}

	/*static testMethod void testParse() {
		String json=		'{"Route": [{"Name": "2089-3", "RouteDate": "", "RouteStartTime": "", "RouteEndTime": "", "SiteName": "", "Driver": "", "Vehicle": "", "Status": "", '+
		'"Records": [{"Id": ["a0d4o00000BP54KAAT"], "Name": ["SO-0000014708"], "TimeWindow": [["10:00", "16:00"]], "SeqNo": 1, "PlannedArrivalTime": ["8:0", "8:10"],'+
		' "PlannedDepartureTime": "8:30", "VehicleId": 0}, {"Id": ["a0d4o00000BP54UAAT"], "Name": ["SO-0000014710"], "TimeWindow": [["10:00", "16:00"]],'+
		' "SeqNo": 2, "PlannedArrivalTime": ["13:56", "14:6"], "PlannedDepartureTime": "14:26", "VehicleId": 0}, {"Id": ["a0d4o00000BOyrQAAT"],'+
		' "Name": ["SO-0000014522"], "TimeWindow": [["10:00", "16:00"]], "SeqNo": 3, "PlannedArrivalTime": ["13:58", "14:8"],'+
		' "PlannedDepartureTime": "14:28", "VehicleId": 0}, {"Id": ["a0d6s0000012TEyAAM"], "Name": ["SO-0000014737"], "TimeWindow": '+
		' [["10:00", "16:00"]], "SeqNo": 4, "PlannedArrivalTime": ["14:28", "14:38"], "PlannedDepartureTime": "14:58", "VehicleId": 0}, '+
		' {"Id": ["a0d6s0000012TEtAAM"], "Name": ["SO-0000014736"], "TimeWindow": [["10:00", "16:00"]], "SeqNo": 5, "PlannedArrivalTime": ["8:0", "8:10"], "PlannedDepartureTime": "8:30", "VehicleId": 1}, {"Id": ["a0d4o00000BP34pAAD"], "Name": ["SO-0000014629"], "TimeWindow": [["10:00", "16:00"]], "SeqNo": 6, "PlannedArrivalTime": ["14:7", "14:17"], "PlannedDepartureTime": "14:37", "VehicleId": 1}, {"Id": ["a0d4o00000BP3ZjAAL"], "Name": ["SO-0000014649"], "TimeWindow": [["10:00", "16:00"]], "SeqNo": 7, "PlannedArrivalTime": ["10:40", "10:50"], "PlannedDepartureTime": "11:10", "VehicleId": 2}, {"Id": ["a0d4o00000BP4DQAA1"], "Name": ["SO-0000014675"], "TimeWindow": [["10:00", "16:00"]], "SeqNo": 8, "PlannedArrivalTime": ["11:14", "11:24"], "PlannedDepartureTime": "11:44", "VehicleId": 2}, {"Id": ["a0d4o00000BP33rAAD"], "Name": ["SO-0000014622"], "TimeWindow": [["10:00", "16:00"]], "SeqNo": 9, "PlannedArrivalTime": ["11:21", "11:31"], "PlannedDepartureTime": "11:51", "VehicleId": 2}, {"Id": ["a0d4o00000BP5dKAAT"], "Name": ["SO-0000014718"], "TimeWindow": [["10:00", "16:00"]], "SeqNo": 10, "PlannedArrivalTime": ["11:42", "11:52"], "PlannedDepartureTime": "12:12", "VehicleId": 2}, {"Id": ["a0d4o00000BP4zoAAD"], "Name": ["SO-0000014700"], "TimeWindow": [["10:00", "16:00"]], "SeqNo": 11, "PlannedArrivalTime": ["11:58", "12:8"], "PlannedDepartureTime": "12:28", "VehicleId": 2}, {"Id": ["a0d4o00000BP4xgAAD"], "Name": ["SO-0000014699"], "TimeWindow": [["10:00", "16:00"]], "SeqNo": 12, "PlannedArrivalTime": ["12:20", "12:30"], "PlannedDepartureTime": "12:50", "VehicleId": 2}, {"Id": ["a0d4o00000BP4CrAAL"], "Name": ["SO-0000014670"], "TimeWindow": [["10:00", "16:00"]], "SeqNo": 13, "PlannedArrivalTime": ["12:27", "12:37"], "PlannedDepartureTime": "12:57", "VehicleId": 2}, {"Id": ["a0W4o000004qp8JEAQ"], "Name": ["PO-0000016014"], "TimeWindow": [["10:00", "16:00"]], "SeqNo": 14, "PlannedArrivalTime": ["12:36", "12:46"], "PlannedDepartureTime": "13:6", "VehicleId": 2}, {"Id": ["a0W4o000004qp89EAA", "a0W4o000004qkWLEAY"], "Name": ["PO-0000016013", "PO-0000015436"], "TimeWindow": [["10:00", "16:00"], ["10:00", "16:00"]], "SeqNo": 15, "PlannedArrivalTime": ["14:21", "14:31"], "PlannedDepartureTime": "14:51", "VehicleId": 2}, {"Id": ["a0W4o000004qp4xEAA"], "Name": ["PO-0000016002"], "TimeWindow": [["10:00", "16:00"]], "SeqNo": 16, "PlannedArrivalTime": ["16:0", "16:10"], "PlannedDepartureTime": "16:30", "VehicleId": 2}]}, {"Name": "NHWCA", "RouteDate": "", "RouteStartTime": "", "RouteEndTime": "", "SiteName": "", "Driver": "", "Vehicle": "", "Status": "", "Records": [{"Id": ["a0d4o00000BOzuHAAT", "a0d4o00000BOzgFAAT", "a0d4o00000BOzgoAAD", "a0d4o00000BOzgAAAT", "a0d4o00000BOzgUAAT", "a0d4o00000BOzgKAAT", "a0d4o00000BOzgPAAT", "a0d4o00000BOzgeAAD", "a0d4o00000BOzgZAAT", "a0d4o00000BOzgjAAD"], "Name": ["SO-0000014554", "SO-0000014541", "SO-0000014548", "SO-0000014540", "SO-0000014544", "SO-0000014542", "SO-0000014543", "SO-0000014546", "SO-0000014545", "SO-0000014547"], "TimeWindow": [["10:00", "16:00"], ["10:00", "16:00"], ["10:00", "16:00"], ["10:00", "16:00"], ["10:00", "16:00"], ["10:00", "16:00"], ["10:00", "16:00"], ["10:00", "16:00"], ["10:00", "16:00"], ["10:00", "16:00"]], "SeqNo": 1, "PlannedArrivalTime": ["8:0", "8:10"], "PlannedDepartureTime": "8:30", "VehicleId": 0}, {"Id": ["a0d4o00000BP511AAD"], "Name": ["SO-0000014701"], "TimeWindow": [["10:00", "16:00"]], "SeqNo": 2, "PlannedArrivalTime": ["8:0", "8:10"], "PlannedDepartureTime": "8:30", "VehicleId": 1}, {"Id": ["a0d4o00000BP4E4AAL"], "Name": ["SO-0000014679"], "TimeWindow": [["10:00", "16:00"]], "SeqNo": 3, "PlannedArrivalTime": ["13:57", "14:7"], "PlannedDepartureTime": "14:27", "VehicleId": 1}, {"Id": ["a0d4o00000BP5cCAAT"], "Name": ["SO-0000014715"], "TimeWindow": [["10:00", "16:00"]], "SeqNo": 4, "PlannedArrivalTime": ["9:18", "9:28"], "PlannedDepartureTime": "9:48", "VehicleId": 2}, {"Id": ["a0d4o00000BP5cHAAT"], "Name": ["SO-0000014716"], "TimeWindow": [["10:00", "16:00"]], "SeqNo": 5, "PlannedArrivalTime": ["10:0", "10:10"], "PlannedDepartureTime": "10:30", "VehicleId": 2}, {"Id": ["a0d4o00000BP51QAAT"], "Name": ["SO-0000014704"], "TimeWindow": [["10:00", "16:00"]], "SeqNo": 6, "PlannedArrivalTime": ["10:42", "10:52"], "PlannedDepartureTime": "11:12", "VehicleId": 2}, {"Id": ["a0d4o00000BP52iAAD"], "Name": ["SO-0000014705"], "TimeWindow": [["10:00", "16:00"]], "SeqNo": 7, "PlannedArrivalTime": ["8:3", "8:13"], "PlannedDepartureTime": "8:33", "VehicleId": 3}, {"Id": ["a0d4o00000BP4KEAA1"], "Name": ["SO-0000014693"], "TimeWindow": [["10:00", "16:00"]], "SeqNo": 8, "PlannedArrivalTime": ["10:0", "10:10"], "PlannedDepartureTime": "10:30", "VehicleId": 3}, {"Id": ["a0d4o00000BP51BAAT"], "Name": ["SO-0000014702"], "TimeWindow": [["10:00", "16:00"]], "SeqNo": 9, "PlannedArrivalTime": ["10:27", "10:37"], "PlannedDepartureTime": "10:57", "VehicleId": 3}, {"Id": ["a0d4o00000BP5bOAAT"], "Name": ["SO-0000014712"], "TimeWindow": [["10:00", "16:00"]], "SeqNo": 10, "PlannedArrivalTime": ["12:38", "12:48"], "PlannedDepartureTime": "13:8", "VehicleId": 3}, {"Id": ["a0d4o00000BP5c2AAD"], "Name": ["SO-0000014713"], "TimeWindow": [["10:00", "16:00"]], "SeqNo": 11, "PlannedArrivalTime": ["12:47", "12:57"], "PlannedDepartureTime": "13:17", "VehicleId": 3}, {"Id": ["a0d4o00000BP5c7AAD"], "Name": ["SO-0000014714"], "TimeWindow": [["10:00", "16:00"]], "SeqNo": 12, "PlannedArrivalTime": ["14:23", "14:33"], "PlannedDepartureTime": "14:53", "VehicleId": 3}, {"Id": ["a0W4o000004qkWkEAI", "a0W4o000004qmd6EAA"], "Name": ["PO-0000015438", "PO-0000015688"], "TimeWindow": [["10:00", "16:00"], ["10:00", "16:00"]], "SeqNo": 13, "PlannedArrivalTime": ["15:0", "15:10"], "PlannedDepartureTime": "15:30", "VehicleId": 3}, {"Id": ["a0W4o000004qoxDEAQ"], "Name": ["PO-0000015972"], "TimeWindow": [["10:00", "16:00"]], "SeqNo": 14, "PlannedArrivalTime": ["15:28", "15:38"], "PlannedDepartureTime": "15:58", "VehicleId": 3}]}]}'+
		'';
		fromJSON obj = parse(json);
		System.assert(obj != null);
	}*/
}