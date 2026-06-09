package chat.ola.vn.entry.b;

import android.view.View;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.view.OlaRatioImageView;

/* JADX INFO: loaded from: classes.dex */
public class o extends l {
    private OlaRatioImageView a;
    private ProgressBar e;
    private TextView f;
    private String g;

    public o(View view) {
        super(view);
        this.a = (OlaRatioImageView) view.findViewById(R.id.imgNewsThumbnail);
        this.e = (ProgressBar) view.findViewById(R.id.newsThumbnailLoadingProgressBar);
        this.f = (TextView) view.findViewById(R.id.txtNewsThumbnailLabel);
    }

    private void a(CharSequence charSequence) {
        if (charSequence == null) {
            this.a.setVisibility(8);
        }
        this.a.setVisibility(0);
        this.g = charSequence.toString();
        switch (chat.ola.vn.util.o.g(this.g)) {
            case 2:
                this.a.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
                this.a.setImageResource(R.drawable.ic_media_sound);
                break;
            case 3:
                this.a.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
                this.a.setImageResource(R.drawable.ic_media_sound);
                break;
            default:
                this.a.setScaleType(ImageView.ScaleType.CENTER_CROP);
                chat.ola.vn.c.t.a().c(this.g, this.a, this.e);
                break;
        }
    }

    @Override // chat.ola.vn.entry.b.l
    public void a(chat.ola.vn.entry.c cVar, int i) {
        TextView textView;
        CharSequence charSequenceE;
        if (cVar.e() != null) {
            textView = this.f;
            charSequenceE = cVar.e();
        } else {
            textView = this.f;
            charSequenceE = "";
        }
        textView.setText(charSequenceE);
        this.f.setTextSize(2, this.d);
        this.a.setTag(cVar);
        this.a.setOnClickListener(this.b);
        a(cVar.d());
    }
}
