//To Share JS code into multiple LWC by using ECMAScript Module

// To export into ECMAScript module
const getBMI = function (weightInKgs,heightInMts){
    try{
        return weightInKgs/(heightInMts*heightInMts);
        }catch(error){
            return undefined;
        }
}

//To export ECMAScript function
export{getBMI};