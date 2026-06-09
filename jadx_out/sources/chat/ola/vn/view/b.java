package chat.ola.vn.view;

import android.os.Bundle;
import android.os.Parcelable;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public abstract class b extends PagerAdapter {
    private final FragmentManager a;
    private FragmentTransaction b = null;
    private ArrayList<Fragment.SavedState> c = new ArrayList<>();
    private ArrayList<Fragment> d = new ArrayList<>();
    private Fragment e = null;

    public b(FragmentManager fragmentManager) {
        this.a = fragmentManager;
    }

    public static String a(int i, long j) {
        return "android:switcher:" + i + ":" + j;
    }

    public Fragment a(ViewPager viewPager, int i) {
        try {
            return this.a.findFragmentByTag(a(viewPager.getId(), i));
        } catch (Throwable th) {
            th.printStackTrace();
            return null;
        }
    }

    public abstract Fragment b(int i);

    @Override // android.support.v4.view.PagerAdapter
    public void destroyItem(ViewGroup viewGroup, int i, Object obj) {
        Fragment fragment = (Fragment) obj;
        if (this.b == null) {
            this.b = this.a.beginTransaction();
        }
        while (this.c.size() <= i) {
            this.c.add(null);
        }
        this.c.set(i, this.a.saveFragmentInstanceState(fragment));
        this.d.set(i, null);
        this.b.remove(fragment);
    }

    @Override // android.support.v4.view.PagerAdapter
    public void finishUpdate(ViewGroup viewGroup) {
        if (this.b != null) {
            this.b.commitAllowingStateLoss();
            this.b = null;
            this.a.executePendingTransactions();
        }
    }

    @Override // android.support.v4.view.PagerAdapter
    public Object instantiateItem(ViewGroup viewGroup, int i) {
        Fragment.SavedState savedState;
        Fragment fragment;
        if (this.d.size() > i && (fragment = this.d.get(i)) != null) {
            return fragment;
        }
        if (this.b == null) {
            this.b = this.a.beginTransaction();
        }
        Fragment fragmentB = b(i);
        if (this.c.size() > i && (savedState = this.c.get(i)) != null) {
            fragmentB.setInitialSavedState(savedState);
        }
        while (this.d.size() <= i) {
            this.d.add(null);
        }
        fragmentB.setMenuVisibility(false);
        fragmentB.setUserVisibleHint(false);
        this.d.set(i, fragmentB);
        this.b.add(viewGroup.getId(), fragmentB, a(viewGroup.getId(), i));
        return fragmentB;
    }

    @Override // android.support.v4.view.PagerAdapter
    public boolean isViewFromObject(View view, Object obj) {
        return ((Fragment) obj).getView() == view;
    }

    @Override // android.support.v4.view.PagerAdapter
    public void restoreState(Parcelable parcelable, ClassLoader classLoader) {
        if (parcelable != null) {
            Bundle bundle = (Bundle) parcelable;
            bundle.setClassLoader(classLoader);
            Parcelable[] parcelableArray = bundle.getParcelableArray("states");
            this.c.clear();
            this.d.clear();
            if (parcelableArray != null) {
                for (Parcelable parcelable2 : parcelableArray) {
                    this.c.add((Fragment.SavedState) parcelable2);
                }
            }
            for (String str : bundle.keySet()) {
                if (str.startsWith("f")) {
                    int i = Integer.parseInt(str.substring(1));
                    Fragment fragment = this.a.getFragment(bundle, str);
                    if (fragment != null) {
                        while (this.d.size() <= i) {
                            this.d.add(null);
                        }
                        fragment.setMenuVisibility(false);
                        this.d.set(i, fragment);
                    } else {
                        Log.w("FragmentStatePagerAdapter", "Bad fragment at key " + str);
                    }
                }
            }
        }
    }

    @Override // android.support.v4.view.PagerAdapter
    public Parcelable saveState() {
        Bundle bundle;
        if (this.c.size() > 0) {
            bundle = new Bundle();
            Fragment.SavedState[] savedStateArr = new Fragment.SavedState[this.c.size()];
            this.c.toArray(savedStateArr);
            bundle.putParcelableArray("states", savedStateArr);
        } else {
            bundle = null;
        }
        for (int i = 0; i < this.d.size(); i++) {
            Fragment fragment = this.d.get(i);
            if (fragment != null) {
                if (bundle == null) {
                    bundle = new Bundle();
                }
                this.a.putFragment(bundle, "f" + i, fragment);
            }
        }
        return bundle;
    }

    @Override // android.support.v4.view.PagerAdapter
    public void setPrimaryItem(ViewGroup viewGroup, int i, Object obj) {
        Fragment fragment = (Fragment) obj;
        if (fragment != this.e) {
            if (this.e != null) {
                this.e.setMenuVisibility(false);
                this.e.setUserVisibleHint(false);
            }
            if (fragment != null) {
                fragment.setMenuVisibility(true);
                fragment.setUserVisibleHint(true);
            }
            this.e = fragment;
        }
    }

    @Override // android.support.v4.view.PagerAdapter
    public void startUpdate(ViewGroup viewGroup) {
    }
}
