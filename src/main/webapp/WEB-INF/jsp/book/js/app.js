App = Ember.Application.create();

//Adapter
App.ApplicationAdapter = DS.RESTAdapter.extend({
  namespace: 'ember-spring'
});

//Spring Serializer
App.SpringSerializer = DS.RESTSerializer.extend({
	  serializeIntoHash: function(hash, type, record, options) {
			var serialized = this.serialize(record, options);
			
			//Include the id in the payload
			serialized.id = record.id;
			
			//remove the root element
	    	Ember.merge(hash, serialized);
	  }
});

//Application Serializer
App.ApplicationSerializer = App.SpringSerializer.extend();

//Book Serializer
App.BookSerializer = App.SpringSerializer.extend(DS.EmbeddedRecordsMixin, {
	//Force embedding the posts array into the payload to the server
	attrs: {
	    authors: {
	      serialize: 'records'
	    }
	}
});

//Models
App.Book = DS.Model.extend({
	name: DS.attr('string'),
	year : DS.attr('number'),
	authors : DS.hasMany('author', {async : true})
});

App.User = DS.Model.extend({
	name: DS.attr('string'),
	books : DS.hasMany('book', {async : true})
});

//Router
App.Router.map(function() {
    this.resource('books', function() {
        this.route('book', { path: '/:book_id' });
    });
});

//Routes
App.BooksRoute = Ember.Route.extend({
  model: function() {
    return this.store.find('book');
  }
});

//Controllers
App.BooksController = Ember.ObjectController.extend({

	actions : {
		save : function(book) {
	        var self = this;
	        book.save().then(function() {
				alert(self.store.metadataFor("book").serverSaid);
			});
		}
	}

});

App.AuthorsBookController = Ember.ObjectController.extend({
	actions : {
	save : function(author) {
	        var self = this;
	        author.save().then(function() {
				alert(self.store.metadataFor("author").serverSaid);
			});
		}
	}
});



