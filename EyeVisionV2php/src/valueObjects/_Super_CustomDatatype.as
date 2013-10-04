/**
 * This is a generated class and is not intended for modfication.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - CustomDatatype.as.
 */

package valueObjects
{
import com.adobe.fiber.services.IFiberManagingService;
import com.adobe.fiber.valueobjects.IValueObject;
import flash.events.Event;
import flash.events.EventDispatcher;
import mx.events.PropertyChangeEvent;

import flash.net.registerClassAlias;
import flash.net.getClassByAlias;
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.valueobjects.IPropertyIterator;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;

use namespace model_internal;

[ExcludeClass]
public class _Super_CustomDatatype extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void 
    {
    }   
     
    model_internal static function initRemoteClassAliasAllRelated() : void 
    {
    }

	model_internal var _dminternal_model : _CustomDatatypeEntityMetadata;

	/**
	 * properties
	 */
	private var _internal_id : int;
	private var _internal_original_image : String;
	private var _internal_username : String;
	private var _internal_customized_image : String;
	private var _internal_sequence_of_actions : String;
	private var _internal_number_of_times_tested : int;
	private var _internal_percieved_image : String;
	private var _internal_symptom : String;

    private static var emptyArray:Array = new Array();

    /**
     * derived property cache initialization
     */  
    model_internal var _cacheInitialized_isValid:Boolean = false;   
    
	model_internal var _changeWatcherArray:Array = new Array();   

	public function _Super_CustomDatatype() 
	{	
		_model = new _CustomDatatypeEntityMetadata(this);
	
		// Bind to own data properties for cache invalidation triggering  
       
	}

    /**
     * data property getters
     */
	[Bindable(event="propertyChange")] 
    public function get id() : int    
    {
            return _internal_id;
    }    
	[Bindable(event="propertyChange")] 
    public function get original_image() : String    
    {
            return _internal_original_image;
    }    
	[Bindable(event="propertyChange")] 
    public function get username() : String    
    {
            return _internal_username;
    }    
	[Bindable(event="propertyChange")] 
    public function get customized_image() : String    
    {
            return _internal_customized_image;
    }    
	[Bindable(event="propertyChange")] 
    public function get sequence_of_actions() : String    
    {
            return _internal_sequence_of_actions;
    }    
	[Bindable(event="propertyChange")] 
    public function get number_of_times_tested() : int    
    {
            return _internal_number_of_times_tested;
    }    
	[Bindable(event="propertyChange")] 
    public function get percieved_image() : String    
    {
            return _internal_percieved_image;
    }    
	[Bindable(event="propertyChange")] 
    public function get symptom() : String    
    {
            return _internal_symptom;
    }    

    /**
     * data property setters
     */      
    public function set id(value:int) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:int = _internal_id;               
        if (oldValue !== value)
        {
            _internal_id = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "id", oldValue, _internal_id));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set original_image(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_original_image == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_original_image;               
        if (oldValue !== value)
        {
            _internal_original_image = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "original_image", oldValue, _internal_original_image));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set username(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_username == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_username;               
        if (oldValue !== value)
        {
            _internal_username = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "username", oldValue, _internal_username));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set customized_image(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_customized_image == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_customized_image;               
        if (oldValue !== value)
        {
            _internal_customized_image = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "customized_image", oldValue, _internal_customized_image));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set sequence_of_actions(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_sequence_of_actions == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_sequence_of_actions;               
        if (oldValue !== value)
        {
            _internal_sequence_of_actions = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sequence_of_actions", oldValue, _internal_sequence_of_actions));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set number_of_times_tested(value:int) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:int = _internal_number_of_times_tested;               
        if (oldValue !== value)
        {
            _internal_number_of_times_tested = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "number_of_times_tested", oldValue, _internal_number_of_times_tested));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set percieved_image(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_percieved_image == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_percieved_image;               
        if (oldValue !== value)
        {
            _internal_percieved_image = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "percieved_image", oldValue, _internal_percieved_image));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set symptom(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_symptom == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_symptom;               
        if (oldValue !== value)
        {
            _internal_symptom = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "symptom", oldValue, _internal_symptom));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    

    /**
     * data property setter listeners
     */   

   model_internal function setterListenerAnyConstraint(value:flash.events.Event):void
   {
        if (model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }        
   }   

    /**
     * valid related derived properties
     */
    model_internal var _isValid : Boolean;
    model_internal var _invalidConstraints:Array = new Array();
    model_internal var _validationFailureMessages:Array = new Array();

    /**
     * derived property calculators
     */

    /**
     * isValid calculator
     */
    model_internal function calculateIsValid():Boolean
    {
        var violatedConsts:Array = new Array();    
        var validationFailureMessages:Array = new Array();    

		if (_model.isOriginal_imageAvailable && _internal_original_image == null)
		{
			violatedConsts.push("original_imageIsRequired");
			validationFailureMessages.push("original_image is required");
		}
		if (_model.isUsernameAvailable && _internal_username == null)
		{
			violatedConsts.push("usernameIsRequired");
			validationFailureMessages.push("username is required");
		}
		if (_model.isCustomized_imageAvailable && _internal_customized_image == null)
		{
			violatedConsts.push("customized_imageIsRequired");
			validationFailureMessages.push("customized_image is required");
		}
		if (_model.isSequence_of_actionsAvailable && _internal_sequence_of_actions == null)
		{
			violatedConsts.push("sequence_of_actionsIsRequired");
			validationFailureMessages.push("sequence_of_actions is required");
		}
		if (_model.isPercieved_imageAvailable && _internal_percieved_image == null)
		{
			violatedConsts.push("percieved_imageIsRequired");
			validationFailureMessages.push("percieved_image is required");
		}
		if (_model.isSymptomAvailable && _internal_symptom == null)
		{
			violatedConsts.push("symptomIsRequired");
			validationFailureMessages.push("symptom is required");
		}

		var styleValidity:Boolean = true;
	
	
	
	
	
	
	
	
    
        model_internal::_cacheInitialized_isValid = true;
        model_internal::invalidConstraints_der = violatedConsts;
        model_internal::validationFailureMessages_der = validationFailureMessages;
        return violatedConsts.length == 0 && styleValidity;
    }  

    /**
     * derived property setters
     */

    model_internal function set isValid_der(value:Boolean) : void
    {
       	var oldValue:Boolean = model_internal::_isValid;               
        if (oldValue !== value)
        {
        	model_internal::_isValid = value;
        	_model.model_internal::fireChangeEvent("isValid", oldValue, model_internal::_isValid);
        }        
    }

    /**
     * derived property getters
     */

    [Transient] 
	[Bindable(event="propertyChange")] 
    public function get _model() : _CustomDatatypeEntityMetadata
    {
		return model_internal::_dminternal_model;              
    }	
    
    public function set _model(value : _CustomDatatypeEntityMetadata) : void       
    {
    	var oldValue : _CustomDatatypeEntityMetadata = model_internal::_dminternal_model;               
        if (oldValue !== value)
        {
        	model_internal::_dminternal_model = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "_model", oldValue, model_internal::_dminternal_model));
        }     
    }      

    /**
     * methods
     */  


    /**
     *  services
     */                  
     private var _managingService:com.adobe.fiber.services.IFiberManagingService;
    
     public function set managingService(managingService:com.adobe.fiber.services.IFiberManagingService):void
     {
         _managingService = managingService;
     }                      
     
    model_internal function set invalidConstraints_der(value:Array) : void
    {  
     	var oldValue:Array = model_internal::_invalidConstraints;
     	// avoid firing the event when old and new value are different empty arrays
        if (oldValue !== value && (oldValue.length > 0 || value.length > 0))
        {
            model_internal::_invalidConstraints = value;   
			_model.model_internal::fireChangeEvent("invalidConstraints", oldValue, model_internal::_invalidConstraints);   
        }     	             
    }             
    
     model_internal function set validationFailureMessages_der(value:Array) : void
    {  
     	var oldValue:Array = model_internal::_validationFailureMessages;
     	// avoid firing the event when old and new value are different empty arrays
        if (oldValue !== value && (oldValue.length > 0 || value.length > 0))
        {
            model_internal::_validationFailureMessages = value;   
			_model.model_internal::fireChangeEvent("validationFailureMessages", oldValue, model_internal::_validationFailureMessages);   
        }     	             
    }        
     
     // Individual isAvailable functions     
	// fields, getters, and setters for primitive representations of complex id properties

}

}
