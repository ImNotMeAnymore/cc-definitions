--- @meta _

--- @alias peripheral.side 
--- | "front"
--- | "back"
--- | "left"
--- | "right"
--- | "top"
--- | "bottom"

--- @alias peripheral.name string
--- | peripheral.side


---@class peripheral
peripheral = {}



---@class peripheral.wrapped
---@field getDocs fun(): table<string, string>
---@field getMetadata fun(): table<string, any> -- If Plethora is installed
---@field [string] fun(...:any): any -- Any other method the peripheral might provide

---Get a table with all methods of a peripheral given its name
---@param name peripheral.name
---@return peripheral.wrapped|nil wrapped
function peripheral.wrap(name) end


---Call a method on the named peripheral
---@param name peripheral.name
---@param method string
---@param ... any Arguments to be passed to the method 
---@return any ...
function peripheral.call(name, method, ...) end

---Find all peripherals of a specific type and return them wrapped
---@param type string
---@param filter? fun(name: peripheral.name, wrapped: peripheral.wrapped): boolean A filter, takes the name and wrapped peripheral and determines whether or not it should actually be returned
---@return peripheral.wrapped ... -- 0 or more wrapped peripherals or nil if none match
function peripheral.find(type, filter) end

---Get the methods of the named peripheral
---@param name peripheral.name
---@return string[]|nil methods List of methods or nil if there is no such peripheral
function peripheral.getMethods(name) end


---Get the name of a wrapped peripheral
---@param wrapped peripheral.wrapped
---@return peripheral.name name
function peripheral.getName(wrapped) end

---Get a list of all available peripherals
---
---If attached to a side, its name will be the side it's attached to, otherwise it'll
---have the name the network assigned to it, like "chest_1"
---@return peripheral.name[] peripherals All the connected peripherals
function peripheral.getNames() end

---Get the type of peripheral connected to the name provided
---@param name peripheral.name|peripheral.wrapped 
---@return string|nil type The type of peripheral attached to the name
function peripheral.getType(name) end


---Check if a peripheral is present given its name
---@param name peripheral.name
---@return boolean isPresent
function peripheral.isPresent(name) end
