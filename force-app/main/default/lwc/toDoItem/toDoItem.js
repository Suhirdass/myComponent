import { LightningElement,api } from 'lwc';
//updating toDos
import updateTodo from "@salesforce/apex/ToDoController.updateTodo";
//deleting toDos
import deleteTodo from "@salesforce/apex/ToDoController.deleteTodo";

export default class ToDoItem extends LightningElement {

    // *** Public Property - to accept the value from parent component ***//
    // communicate child to parent , we can use custom event
    @api todoId;
    @api todoName;
    @api done = false;

    // get property to return container class & providing css to completed and upcoming class
    get containerClass(){
        return this.done ? "todo completed" : "todo upcoming";
    }

    //get property 
    // get property to return icon name based on item state
    // for completed item, return check icon, else return add icon
    get iconName(){
        return this.done ? "utility:check" : "utility:add";
    }

    //calling update method (apex method) through onclick handler
    /**
   * Update handler to edit current item
   * You can switch the item status between completed and uncompleted
   * Make a call to server to update the item
   */
    upDateHandler(){
        //construct json object, we can serialized and passed payload parameter into apex update method
        const todo ={
            todoId : this.todoId,
            todoName : this.todoName,
            //switch done property for upcoming and completed task
            done : !this.done
        };

        //calling apex update method
        ////make a call to server to update the item
        updateTodo({payload : JSON.stringify(todo)}).then(result =>{
            //to check , the result is not null if(result)
            console.log("Items updated Successfully");

            /*fire an event to parent component, we are telling todo item is updated or deleted to parent component
             && listen and fetch new list from server*/
             //creating custom event , update is event name
             //Event can be to communicate from the child component to the parent component.you can also pass the payload/data along with the event 
             //Ex: const updateEvent = new CustomEvent('update',{detai: payload} )-- {detai:} it is mandatory
             //on successful update, fire an event to notify parent component
             const updateEvent = new CustomEvent('update');
             this.dispatchEvent(updateEvent);
         }).catch(error => {
           console.error("error in update todo item " + error);
         });
    }


    //calling delete method (apex method) through onclick handler
    /**
   * Delete handler to delete current item
   * Make a call to server to delete the item
   */
    deleteHandler(){
         //make a call to server to delete item
        deleteTodo({todoId : this.todoId})
        .then(result => {
            //to check , the result is not null
            console.log("Items deleted Successfully");


            /*fire an event to parent component, we are telling todo item is updated or deleted to parent component
             && listen and fetch new list from server*/
             //creating custom event , delete is event name
             //Event can be to communicate from the child component to the parent component.you can also pass the payload/data along with the event 
             //Ex: const updateEvent = new CustomEvent('delete',{detai: payload} )-- {detai:} it is mandatory
             //on successful delete, fire an event to notify parent component
             //this.dispatchEvent(new CustomEvent("delete", { detail: this.todoId }));
             const deleteEvent = new CustomEvent('delete');
             this.dispatchEvent(deleteEvent);
         }).catch(error => {
           console.error("error in delete todo item " + error);
         });

    }
}