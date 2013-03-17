/**
 *
 * Copyright 2012(C) by Piotr Kucharski.
 * email: suspendmode@gmail.com
 * mobile: +48 791 630 277
 *
 * All rights reserved. Any use, copying, modification, distribution and selling of this software and it's documentation
 * for any purposes without authors' written permission is hereby prohibited.
 *
 */
package
{
	import flash.display.Sprite;
	import flash.events.ErrorEvent;

	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;

	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;
	import robotlegs.bulkloader.BulkLoaderExtension;
	import robotlegs.sound.SoundManagerExtension;
	import robotlegs.sound.api.ISoundManager;


	/**
	 *
	 * @author suspendmode@gmail.com
	 *
	 */
	public class sound_manager_example extends Sprite
	{
		public static const LOOP_URL:String="assets/sounds/loops/Childish Innocence (SB).mp3";

		public static const LOOP_ID:String="LOOP_ID";

		public static const SHOT_URL:String="assets/sounds/events/buttonBig.mp3";

		public static const SHOT_ID:String="SHOT_ID";

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		private var context:IContext;

		public function sound_manager_example()
		{
			context=new Context();
			context.install(MVCSBundle);
			context.install(BulkLoaderExtension, SoundManagerExtension);
			context.configure(new ContextView(this));

			var loader:BulkLoader=context.injector.getInstance(BulkLoader);
			loader.addEventListener(BulkProgressEvent.COMPLETE, onLoadComplete);
			loader.addEventListener(ErrorEvent.ERROR, onError);

			loader.add(LOOP_URL, {id: LOOP_ID, isLoaded: true});
			loader.add(SHOT_URL, {id: SHOT_ID, isLoaded: true});

			loader.start();

		}

		protected function onLoadComplete(event:BulkProgressEvent):void
		{
			var soundManager:ISoundManager=context.injector.getInstance(ISoundManager);

			soundManager.play(SHOT_ID, null, 0.2, 0.5, 0).loop(2);

		/*

		soundManager.play(id, delay: Number = 0.5, fadeInTime: Number = 0).shot(volume:1, pan:1).onComplete(listener);

		soundManager.mute(id);

		soundManager.muteAll(id);

		soundManager.play("id1").shot().setVolume(100).onComplete(listener);
		////never occur
		//soundManager.play("id1").shot().setVolume(100).onSoundComplete(listener);

		soundManager.play("id1").loop(3).setVolume(100).onComplete(listener);
		soundManager.play("id1").loop(3).setVolume(100).onSoundComplete(listener);

		//never occur
		//soundManager.play("id1").endlessLoop().onComplete(listener);
		soundManager.play("id1").endlessLoop().onSoundComplete(listener);

		soundManager.stop("id1");*/
		}

		private function onError(event:ErrorEvent):void
		{
			trace(event.text);
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
