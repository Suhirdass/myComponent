/**
     * Iterable class for pagination
     */
    public class CustomIterable implements Iterator<list<Object>>{
        
        public List<Object> innerList{get; set;}
        public List<Object> requestedList{get; set;}

        Integer currentIndex {get; set;} 
        public Integer setPageSize {get; set;}
        public Integer totalPages {get; set;}
        public Integer currentPage {get; set;}

        // Constructor
        public CustomIterable(List<Object> objectList, Integer pageSize){
            requestedList = new list<Object>();     
            innerList = objectList;
            setPageSize = pageSize;
            currentIndex = 0;
            currentPage = 0;
            Decimal totalPagesDecimal = Decimal.valueOf(innerList.size()) / Decimal.valueOf(setPageSize);
            totalPages = totalPagesDecimal == 0.0 ? 1 : Integer.valueOf(totalPagesDecimal.round(System.RoundingMode.UP));
        }   

        // Flag to check if next link is visible
        public boolean hasNext(){
            if(currentIndex >= innerList.size()) {
                return false;
                 
            } else {
                return true;
            }
        } 

        // Flag to check if previous link is visible
        public boolean hasPrevious(){ 
            if(currentIndex <= setPageSize) {
                return false;
                 
            } else {
                return true;
            }
        }   

        // Retrieves next page records
        public List<Object> next(){       
            requestedList = new list<Object>(); 
            integer startNumber;
            integer size = innerList.size();
            if(hasNext()){
                if(size <= (currentIndex + setPageSize)){
                    startNumber = currentIndex;
                    currentIndex = size;
                }
                else{
                    currentIndex = (currentIndex + setPageSize);
                    startNumber = (currentIndex - setPageSize);
                }
           
                for(integer start = startNumber; start < currentIndex; start++){
                    requestedList.add(innerList[start]);
                }
                currentPage++;
            } 
            return requestedList;
        } 

        // Retrieves previous page records
        public List<Object> previous(){      
            requestedList = new list<Object>(); 
            integer size = innerList.size(); 
            if(currentIndex == size){
                if(math.mod(size, setPageSize) > 0){
                    currentIndex = size - math.mod(size, setPageSize);
                }
                else{
                    currentIndex = (size - setPageSize);
                } 
            }
            else{
                currentIndex = (currentIndex - setPageSize);
            }
            
            for(integer start = (currentIndex - setPageSize); start < currentIndex; ++start){
                requestedList.add(innerList[start]);
            }
            currentPage--;
            return requestedList;
        }   
        
        // Retrieves first page records
        public List<Object> first(){       
            requestedList = new List<Object>();
            currentIndex = setPageSize; 
            for(integer start = 0; start < setPageSize; start++){
                requestedList.add(innerList[start]);
            }
            currentPage = 1;
            return requestedList;
        }
        
        // Retrieves last page records
        public List<Object> last(){       
            requestedList = new list<Object>(); 
            integer startNumber;
            integer size = innerList.size();
            currentIndex = size;
            
            startNumber = Math.mod(size, setPageSize);
            if(startNumber == 0) {
                startNumber = size - setPageSize;
            } else {
                startNumber = size - startNumber;
            }
            
            for(integer start = startNumber; start < size; start++){
                requestedList.add(innerList[start]);
            }
            currentPage = totalPages;
            return requestedList;
        }
    }