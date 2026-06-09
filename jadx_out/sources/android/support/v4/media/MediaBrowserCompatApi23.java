package android.support.v4.media;

import android.media.browse.MediaBrowser;
import android.os.Parcel;
import android.support.annotation.NonNull;
import android.support.annotation.RequiresApi;

/* JADX INFO: loaded from: classes.dex */
@RequiresApi(23)
class MediaBrowserCompatApi23 {

    interface ItemCallback {
        void onError(@NonNull String str);

        void onItemLoaded(Parcel parcel);
    }

    static class ItemCallbackProxy<T extends ItemCallback> extends MediaBrowser.ItemCallback {
        protected final T mItemCallback;

        public ItemCallbackProxy(T t) {
            this.mItemCallback = t;
        }

        @Override // android.media.browse.MediaBrowser.ItemCallback
        public void onError(@NonNull String str) {
            this.mItemCallback.onError(str);
        }

        /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
        @Override // android.media.browse.MediaBrowser.ItemCallback
        public void onItemLoaded(MediaBrowser.MediaItem mediaItem) {
            Parcel parcelObtain;
            T t;
            if (mediaItem == null) {
                t = this.mItemCallback;
                parcelObtain = null;
            } else {
                parcelObtain = Parcel.obtain();
                mediaItem.writeToParcel(parcelObtain, 0);
                t = this.mItemCallback;
            }
            t.onItemLoaded(parcelObtain);
        }
    }

    MediaBrowserCompatApi23() {
    }

    public static Object createItemCallback(ItemCallback itemCallback) {
        return new ItemCallbackProxy(itemCallback);
    }

    public static void getItem(Object obj, String str, Object obj2) {
        ((MediaBrowser) obj).getItem(str, (MediaBrowser.ItemCallback) obj2);
    }
}
