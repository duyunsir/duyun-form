<style type="text/css">
	.ck-content {
	   min-height: 200px;
	}
</style>
<div id="{$_ns}">{$_field.value|html_entity_decode}</div>
<script src="{$Public}js/plugins/ckeditor5/ckeditor.js"></script>
<script src="{$Public}js/plugins/ckeditor5/translations/zh-cn.js"></script>
<script>
		ClassicEditor.create( document.querySelector( '#{$_ns}' ),{
			placeholder: "<?php echo (isset($_field['config']['prompt']) && ($_field['config']['prompt'] !== '')?$_field['config']['prompt']:''); ?> ",
			toolbar: {
				items: [
					'exportPdf',
					'|','heading',
					'|','bold', 'italic', 'underline', 'strikethrough', 'code','subscript', 'superscript','blockQuote','strike',
					'|','FontBackgroundColor', 'FontColor', 'FontSize', 'FontFamily',
					'|','indent','outdent','alignment', 'bulletedList','numberedList','todoList',
					'|','codeBlock','highlight','RemoveFormat', 'Link',
					'|','restrictedEditing','selectAll','specialCharacters',
					'|','insertTable','horizontalLine','PageBreak','pastePlainText',
					'|','ckfinder','imageUpload','mediaEmbed','trackChanges','restrictedEditingException',
					'|','undo','redo'
				],
				viewportTopOffset: 30,
		        shouldNotGroupWhenFull: true
			},
			
			fontSize: {
	            options: ['10px','11px','12px','14px','16px','18px','20px','24px','36px','72px']
	        },
	        fontFamily: {
	            options: [
	                '宋体,SimSun','微软雅黑,Microsoft YaHei','楷体,楷体_GB2312, SimKai','黑体, SimHei','隶书, SimLi',
	                'Arial, Helvetica, sans-serif',
				    'Courier New, Courier, monospace',
				    'Georgia, serif',
				    'Lucida Sans Unicode, Lucida Grande, sans-serif',
				    'Tahoma, Geneva, sans-serif',
				    'Times New Roman, Times, serif',
				    'Trebuchet MS, Helvetica, sans-serif',
				    'Verdana, Geneva, sans-serif'
	            ]
	        },
			fontBackgroundColor: {
				colors: ["hsl(0,0%,0%)", "hsl(0,0%,12.5%)", "hsl(0,0%,25%)", "hsl(0,0%,37.5%)", "hsl(0,0%,50%)", "hsl(0,0%,62.50%)", "hsl(0,0%,75%)", "hsl(0,0%,87.5%)",
				{
					color: "hsl(0,0%,100%)",
					hasBorder: !0
				}, "hsl(0,100%,10%)", "hsl(0,100%,20%)", "hsl(0,100%,30%)", "hsl(0,100%,40%)", "hsl(0,100%,50%)", "hsl(0,100%,60%)", "hsl(0,100%,70%)", "hsl(0,100%,80%)",
				{
					color: "hsl(0,100%,90%)",
					hasBorder: !0
				}, "hsl(30,100%,10%)", "hsl(30,100%,20%)", "hsl(30,100%,30%)", "hsl(30,100%,40%)", "hsl(30,100%,50%)", "hsl(30,100%,60%)", "hsl(30,100%,70%)", "hsl(30,100%,80%)",
				{
					color: "hsl(30,100%,90%)",
					hasBorder: !0
				}, "hsl(60,100%,10%)", "hsl(60,100%,20%)", "hsl(60,100%,30%)", "hsl(60,100%,40%)", "hsl(60,100%,50%)", "hsl(60,100%,60%)", "hsl(60,100%,70%)", "hsl(60,100%,80%)",
				{
					color: "hsl(60,100%,90%)",
					hasBorder: !0
				}, "hsl(90,100%,10%)", "hsl(90,100%,20%)", "hsl(90,100%,30%)", "hsl(90,100%,40%)", "hsl(90,100%,50%)", "hsl(90,100%,60%)", "hsl(90,100%,70%)", "hsl(90,100%,80%)",
				{
					color: "hsl(90,100%,90%)",
					hasBorder: !0
				}, "hsl(120,100%,10%)", "hsl(120,100%,20%)", "hsl(120,100%,30%)", "hsl(120,100%,40%)", "hsl(120,100%,50%)", "hsl(120,100%,60%)", "hsl(120,100%,70%)", "hsl(120,100%,80%)",
				{
					color: "hsl(120,100%,90%)",
					hasBorder: !0
				}, "hsl(150,100%,10%)", "hsl(150,100%,20%)", "hsl(150,100%,30%)", "hsl(150,100%,40%)", "hsl(150,100%,50%)", "hsl(150,100%,60%)", "hsl(150,100%,70%)", "hsl(150,100%,80%)",
				{
					color: "hsl(150,100%,90%)",
					hasBorder: !0
				}, "hsl(180,100%,10%)", "hsl(180,100%,20%)", "hsl(180,100%,30%)", "hsl(180,100%,40%)", "hsl(180,100%,50%)", "hsl(180,100%,60%)", "hsl(180,100%,70%)", "hsl(180,100%,80%)",
				{
					color: "hsl(180,100%,90%)",
					hasBorder: !0
				}, "hsl(210,100%,10%)", "hsl(210,100%,20%)", "hsl(210,100%,30%)", "hsl(210,100%,40%)", "hsl(210,100%,50%)", "hsl(210,100%,60%)", "hsl(210,100%,70%)", "hsl(210,100%,80%)",
				{
					color: "hsl(210,100%,90%)",
					hasBorder: !0
				}, "hsl(240,100%,10%)", "hsl(240,100%,20%)", "hsl(240,100%,30%)", "hsl(240,100%,40%)", "hsl(240,100%,50%)", "hsl(240,100%,60%)", "hsl(240,100%,70%)", "hsl(240,100%,80%)",
				{
					color: "hsl(240,100%,90%)",
					hasBorder: !0
				}, "hsl(270,100%,10%)", "hsl(270,100%,20%)", "hsl(270,100%,30%)", "hsl(270,100%,40%)", "hsl(270,100%,50%)", "hsl(270,100%,60%)", "hsl(270,100%,70%)", "hsl(270,100%,80%)",
				{
					color: "hsl(270,100%,90%)",
					hasBorder: !0
				}, "hsl(300,100%,10%)", "hsl(300,100%,20%)", "hsl(300,100%,30%)", "hsl(300,100%,40%)", "hsl(300,100%,50%)", "hsl(300,100%,60%)", "hsl(300,100%,70%)", "hsl(300,100%,80%)",
				{
					color: "hsl(300,100%,90%)",
					hasBorder: !0
				}, "hsl(330,100%,10%)", "hsl(330,100%,20%)", "hsl(330,100%,30%)", "hsl(330,100%,40%)", "hsl(330,100%,50%)", "hsl(330,100%,60%)", "hsl(330,100%,70%)", "hsl(330,100%,80%)",
				{
					color: "hsl(330,100%,90%)",
					hasBorder: !0
				}],
				columns: 9,
				documentColors: 18
			},
			fontColor: {
				colors: ["black", "gray", "silver",
				{
					color: "white",
					hasBorder: !0
				}, "maroon", "red", "purple", "fuchsia", "green", "lime", "olive", "yellow", "navy", "blue", "teal", "aqua"],
				columns: 4,
				documentColors: 12
			},
	        ckfinder: {
	            // Open the file manager in the pop-up window.
	            uploadUrl: "{:yunurl('/upload/connector')}?command=QuickUpload&type=Files&responseType=json",
	            // openerMethod: 'popup'
	        },
			image: {
				toolbar: [
					'imageStyle:full',
					'imageStyle:side',
					'|',
					'imageTextAlternative'
				]
			},
			table: {
				contentToolbar: [
					'tableColumn', 'tableRow', 'mergeTableCells','tableProperties', 'tableCellProperties'
				]
			},
			highlight: {
	            options: [
				    { model: 'yellowMarker', class: 'marker-yellow', title: 'Yellow Marker', color: 'var(--ck-highlight-marker-yellow)', type: 'marker' },
				    { model: 'greenMarker', class: 'marker-green', title: 'Green marker', color: 'var(--ck-highlight-marker-green)', type: 'marker' },
				    { model: 'pinkMarker', class: 'marker-pink', title: 'Pink marker', color: 'var(--ck-highlight-marker-pink)', type: 'marker' },
				    { model: 'blueMarker', class: 'marker-blue', title: 'Blue marker', color: 'var(--ck-highlight-marker-blue)', type: 'marker' },
				    { model: 'redPen', class: 'pen-red', title: 'Red pen', color: 'var(--ck-highlight-pen-red)', type: 'pen' },
				    { model: 'greenPen', class: 'pen-green', title: 'Green pen', color: 'var(--ck-highlight-pen-green)', type: 'pen' }
				]
	        },
	        exportPdf: {
	            // stylesheets: [
	            //     './path/to/fonts.css',
	            //     'EDITOR_STYLES',
	            //     './path/to/style.css'
	            // ],
	            fileName: '{$_ns}.pdf',
	            converterOptions: {
	                format: 'A4',
	                margin_top: '20mm',
	                margin_bottom: '20mm',
	                margin_right: '12mm',
	                margin_left: '12mm',
	                page_orientation: 'portrait'
	            }
	        },
			autosave: {
	            save( editor ) {
	                return saveData( editor.getData() );
	            }
	        },
	        wordCount: {
	            onUpdate: stats => {
	                // Prints the current content statistics.
	                console.log( `Characters: ${ stats.characters }\nWords: ${ stats.words }` );
	            }
	        },
	        typing: {
	            transformations: {
	                remove: [
	                    // Do not use the transformations from the
	                    // 'symbols' and 'quotes' groups.
	                    'symbols',
	                    'quotes',

	                    // As well as the following transformations.
	                    'arrowLeft',
	                    'arrowRight'
	                ],

	                extra: [
	                    // Add some custom transformations – e.g. for emojis.
	                    { from: ':)', to: '🙂' },
	                    { from: ':+1:', to: '👍' },
	                    { from: ':tada:', to: '🎉' },

	                    // You can also define patterns using regular expressions.
	                    // Note: The pattern must end with `$` and all its fragments must be wrapped
	                    // with capturing groups.
	                    // The following rule replaces ` "foo"` with ` «foo»`.
	                    {
	                        from: /(^|\s)(")([^"]*)(")$/,
	                        to: [ null, '«', null, '»' ]
	                    },

	                    // Finally, you can define `to` as a callback.
	                    // This (naive) rule will auto-capitalize the first word after a period.
	                    {
	                        from: /(\. )([a-z])$/,
	                        to: matches => [ null, matches[ 1 ].toUpperCase() ]
	                    }
	                ],
	            }
	        },
	        mention: {
	            feeds: [
	                {
	                    marker: '@',
	                    feed: getFeedItems
	                }
		        ]
		    },
	        language: 'zh-cn'
		} )
		.then( editor => {
			window.editor = editor;
		} )
		.catch( error => {
			console.error( 'There was a problem initializing the editor.', error );
		} );

		function saveData( data ) {
		    return new Promise( resolve => {
		        setTimeout( () => {
		            console.log( 'Saved', data );

		            resolve();
		        }, 1000 );
		    } );
		}

		const items = [
		    { id: '@adu', userId: '1', name: 'Barney Stinson', link: 'https://www.imdb.com/title/tt0460649/characters/nm0000439' },
		    { id: '@tdog', userId: '5', name: 'Ted Mosby', link: 'https://www.imdb.com/title/tt0460649/characters/nm1102140' }
		];

		function getFeedItems( queryText ) {
		    // As an example of an asynchronous action, return a promise
		    // that resolves after a 100ms timeout.
		    // This can be a server request or any sort of delayed action.
		    return new Promise( resolve => {
		        setTimeout( () => {
		            const itemsToDisplay = items
		                // Filter out the full list of all items to only those matching the query text.
		                .filter( isItemMatching )
		                // Return 10 items max - needed for generic queries when the list may contain hundreds of elements.
		                .slice( 0, 10 );

		            resolve( itemsToDisplay );
		        }, 100 );
		    } );

		    // Filtering function - it uses the `name` and `username` properties of an item to find a match.
		    function isItemMatching( item ) {
		        // Make the search case-insensitive.
		        const searchString = queryText.toLowerCase();

		        // Include an item in the search results if the name or username includes the current user input.
		        return (
		            item.name.toLowerCase().includes( searchString ) ||
		            item.id.toLowerCase().includes( searchString )
		        );
		    }
		}
</script>