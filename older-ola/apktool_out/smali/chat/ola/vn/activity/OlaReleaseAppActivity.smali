.class public Lchat/ola/vn/activity/OlaReleaseAppActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;


# static fields
.field private static A:Lcom/google/android/gms/ads/InterstitialAd; = null

.field private static B:Z = false

.field private static C:J

.field public static e:Lchat/ola/vn/entity/k;

.field private static x:J

.field private static y:Ljava/lang/Long;

.field private static z:I


# instance fields
.field f:Lchat/ola/vn/view/OlaCachedImageView;

.field g:Landroid/widget/TextView;

.field h:Landroid/widget/RatingBar;

.field i:Landroid/widget/TextView;

.field j:Landroid/widget/Button;

.field k:Lchat/ola/vn/view/OlaRatioImageView;

.field l:Landroid/view/View;

.field m:Lchat/ola/vn/view/OlaRatioImageView;

.field n:Landroid/widget/VideoView;

.field o:Landroid/view/View;

.field p:Landroid/view/View;

.field q:Landroid/widget/TextView;

.field r:Landroid/widget/TextView;

.field s:Landroid/widget/Button;

.field private t:Z

.field private u:Landroid/os/CountDownTimer;

.field private v:Ljava/lang/String;

.field private w:Landroid/widget/TextView;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->t:Z

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->v:Ljava/lang/String;

    return-void
.end method

.method private static D()V
    .locals 6

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    sget-wide v2, Lchat/ola/vn/activity/OlaReleaseAppActivity;->C:J

    sub-long v4, v0, v2

    const-wide/32 v0, 0x2bf20

    cmp-long v2, v4, v0

    if-gez v2, :cond_0

    sget-boolean v0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->B:Z

    if-nez v0, :cond_1

    :cond_0
    new-instance v0, Lcom/google/android/gms/ads/AdRequest$Builder;

    invoke-direct {v0}, Lcom/google/android/gms/ads/AdRequest$Builder;-><init>()V

    invoke-virtual {v0}, Lcom/google/android/gms/ads/AdRequest$Builder;->build()Lcom/google/android/gms/ads/AdRequest;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->A:Lcom/google/android/gms/ads/InterstitialAd;

    invoke-virtual {v1, v0}, Lcom/google/android/gms/ads/InterstitialAd;->loadAd(Lcom/google/android/gms/ads/AdRequest;)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    sput-wide v0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->C:J

    :cond_1
    return-void
.end method

.method private E()V
    .locals 2

    const v0, 0x7f090277

    :try_start_0
    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->f:Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f09051d

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->g:Landroid/widget/TextView;

    const v0, 0x7f090402

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/RatingBar;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->h:Landroid/widget/RatingBar;

    const v0, 0x7f090573

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->i:Landroid/widget/TextView;

    const v0, 0x7f0900ce

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->j:Landroid/widget/Button;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->j:Landroid/widget/Button;

    invoke-virtual {v0, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0905c4

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090278

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaRatioImageView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->k:Lchat/ola/vn/view/OlaRatioImageView;

    const v0, 0x7f090307

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->l:Landroid/view/View;

    const v0, 0x7f090295

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaRatioImageView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->m:Lchat/ola/vn/view/OlaRatioImageView;

    const v0, 0x7f090082

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/VideoView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->n:Landroid/widget/VideoView;

    const v0, 0x7f090083

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->o:Landroid/view/View;

    const v0, 0x7f09023f

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->p:Landroid/view/View;

    const v0, 0x7f09051e

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->q:Landroid/widget/TextView;

    const v0, 0x7f09051c

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->r:Landroid/widget/TextView;

    const v0, 0x7f0900d5

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->s:Landroid/widget/Button;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->s:Landroid/widget/Button;

    invoke-virtual {v0, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0900be

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->w:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->w:Landroid/widget/TextView;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setClickable(Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->w:Landroid/widget/TextView;

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private F()V
    .locals 10

    :try_start_0
    sget-object v0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    if-nez v0, :cond_0

    return-void

    :cond_0
    sget-object v0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object v0, v0, Lchat/ola/vn/entity/k;->m:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "https://play.google.com/store/apps/details?id="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object v1, v1, Lchat/ola/vn/entity/k;->m:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "&rdid="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object v1, v1, Lchat/ola/vn/entity/k;->m:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object v1, v1, Lchat/ola/vn/entity/k;->m:Ljava/lang/String;

    invoke-static {p0, v1}, Lchat/ola/vn/util/b;->k(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    sget-object v1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object v1, v1, Lchat/ola/vn/entity/k;->m:Ljava/lang/String;

    invoke-static {p0, v1}, Lchat/ola/vn/util/b;->i(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_1

    :cond_1
    sget-object v1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object v1, v1, Lchat/ola/vn/entity/k;->m:Ljava/lang/String;

    :goto_0
    invoke-static {p0, v1}, Lchat/ola/vn/util/b;->j(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_1

    :cond_2
    sget-object v0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object v0, v0, Lchat/ola/vn/entity/k;->h:Ljava/lang/String;

    sget-object v1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object v1, v1, Lchat/ola/vn/entity/k;->h:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->f(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_3

    goto :goto_0

    :cond_3
    new-instance v1, Landroid/content/Intent;

    const-string v2, "android.intent.action.VIEW"

    sget-object v3, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object v3, v3, Lchat/ola/vn/entity/k;->h:Ljava/lang/String;

    invoke-static {v3}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v3

    invoke-direct {v1, v2, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->startActivity(Landroid/content/Intent;)V

    :goto_1
    sget-object v1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object v1, v1, Lchat/ola/vn/entity/k;->i:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_4

    goto :goto_2

    :cond_4
    move-object v0, v1

    :goto_2
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    sget-wide v3, Lchat/ola/vn/activity/OlaReleaseAppActivity;->x:J

    const/4 v5, 0x0

    sub-long v5, v1, v3

    const-wide/32 v1, 0x36ee80

    cmp-long v3, v5, v1

    if-ltz v3, :cond_5

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    sput-wide v1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->x:J

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const v2, 0x7f030012

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getStringArray(I)[Ljava/lang/String;

    move-result-object v1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    array-length v4, v1

    int-to-long v4, v4

    rem-long/2addr v2, v4

    long-to-int v2, v2

    aget-object v1, v1, v2

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    sget-object v4, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object v4, v4, Lchat/ola/vn/entity/k;->a:Ljava/lang/String;

    aput-object v4, v2, v3

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    sget-object v2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\n"

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    sget-object v0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object v4, v0, Lchat/ola/vn/entity/k;->k:Ljava/lang/String;

    const/4 v5, 0x0

    const/16 v6, 0x4001

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    invoke-virtual/range {v2 .. v9}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;SSLjava/lang/String;Ljava/lang/String;S)V

    sget-object v0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object v0, v0, Lchat/ola/vn/entity/k;->g:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_5

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    sget-object v1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object v1, v1, Lchat/ola/vn/entity/k;->g:Ljava/lang/String;

    const-string v2, "wap"

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/network/OlaNetworkService;->l(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_5
    return-void
.end method

.method private G()V
    .locals 3

    :try_start_0
    sget-object v0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->finish()V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->g:Landroid/widget/TextView;

    sget-object v1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object v1, v1, Lchat/ola/vn/entity/k;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->r:Landroid/widget/TextView;

    sget-object v1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object v1, v1, Lchat/ola/vn/entity/k;->f:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->h:Landroid/widget/RatingBar;

    sget-object v1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object v1, v1, Lchat/ola/vn/entity/k;->n:Ljava/lang/Float;

    invoke-virtual {v1}, Ljava/lang/Float;->floatValue()F

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/RatingBar;->setRating(F)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->i:Landroid/widget/TextView;

    sget-object v1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object v1, v1, Lchat/ola/vn/entity/k;->l:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->q:Landroid/widget/TextView;

    sget-object v1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object v1, v1, Lchat/ola/vn/entity/k;->e:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->C()V

    sget-object v0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object v0, v0, Lchat/ola/vn/entity/k;->b:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    const/16 v2, 0x8

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->k:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaRatioImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->l:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->H()V

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->k:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaRatioImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->l:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->B()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private H()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->l:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->n:Landroid/widget/VideoView;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->n:Landroid/widget/VideoView;

    invoke-virtual {v0, p0}, Landroid/widget/VideoView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->I()V

    return-void
.end method

.method private I()V
    .locals 4
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    sget-object v0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object v0, v0, Lchat/ola/vn/entity/k;->b:Ljava/lang/String;

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->m:Lchat/ola/vn/view/OlaRatioImageView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaRatioImageView;->setVisibility(I)V

    return-void

    :cond_0
    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "http://img.youtube.com/vi/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object v1, v1, Lchat/ola/vn/entity/k;->b:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "/mqdefault.jpg"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->m:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v1}, Lchat/ola/vn/view/OlaRatioImageView;->getWidth()I

    move-result v1

    const/16 v2, 0x190

    if-gt v1, v2, :cond_1

    sget-boolean v1, Lchat/ola/vn/h;->I:Z

    if-eqz v1, :cond_2

    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "http://img.youtube.com/vi/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object v1, v1, Lchat/ola/vn/entity/k;->b:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "/hqdefault.jpg"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :cond_2
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->m:Lchat/ola/vn/view/OlaRatioImageView;

    iget-object v3, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->p:Landroid/view/View;

    invoke-virtual {v1, v0, v2, v3}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;)V

    sget-object v0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object v0, v0, Lchat/ola/vn/entity/k;->c:Ljava/lang/String;

    if-eqz v0, :cond_3

    sget-object v0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object v0, v0, Lchat/ola/vn/entity/k;->b:Ljava/lang/String;

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->f(Ljava/lang/String;)V

    return-void

    :cond_3
    new-instance v0, Lchat/ola/vn/activity/OlaReleaseAppActivity$4;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaReleaseAppActivity$4;-><init>(Lchat/ola/vn/activity/OlaReleaseAppActivity;)V

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    sget-object v2, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object v2, v2, Lchat/ola/vn/entity/k;->b:Ljava/lang/String;

    invoke-virtual {v1, v2, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/p/o;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaReleaseAppActivity;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->w:Landroid/widget/TextView;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaReleaseAppActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->v:Ljava/lang/String;

    return-object p1
.end method

.method public static a(Landroid/content/Context;)V
    .locals 8

    :try_start_0
    sget-short p0, Lchat/ola/vn/h;->H:S

    if-lez p0, :cond_0

    return-void

    :cond_0
    sget-object p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->A:Lcom/google/android/gms/ads/InterstitialAd;

    if-nez p0, :cond_1

    new-instance p0, Lcom/google/android/gms/ads/InterstitialAd;

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/google/android/gms/ads/InterstitialAd;-><init>(Landroid/content/Context;)V

    sput-object p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->A:Lcom/google/android/gms/ads/InterstitialAd;

    sget-object p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->A:Lcom/google/android/gms/ads/InterstitialAd;

    const/4 v0, 0x3

    invoke-static {v0}, Lchat/ola/vn/util/a;->a(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/google/android/gms/ads/InterstitialAd;->setAdUnitId(Ljava/lang/String;)V

    :cond_1
    sget-object p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->A:Lcom/google/android/gms/ads/InterstitialAd;

    new-instance v0, Lchat/ola/vn/activity/OlaReleaseAppActivity$2;

    invoke-direct {v0}, Lchat/ola/vn/activity/OlaReleaseAppActivity$2;-><init>()V

    invoke-virtual {p0, v0}, Lcom/google/android/gms/ads/InterstitialAd;->setAdListener(Lcom/google/android/gms/ads/AdListener;)V

    sget-object p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->y:Ljava/lang/Long;

    if-nez p0, :cond_2

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p0

    invoke-virtual {p0}, Lchat/ola/vn/e;->c()J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p0

    sput-object p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->y:Ljava/lang/Long;

    :cond_2
    sget p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->z:I

    add-int/lit8 p0, p0, 0x1

    sput p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->z:I

    const-wide/32 v0, 0x493e0

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    sget-object p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->y:Ljava/lang/Long;

    invoke-virtual {p0}, Ljava/lang/Long;->longValue()J

    move-result-wide v4

    const/4 p0, 0x0

    sub-long v6, v2, v4

    cmp-long p0, v6, v0

    if-ltz p0, :cond_4

    sget p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->z:I

    const/16 v0, 0xa

    if-lt p0, v0, :cond_3

    const/4 p0, 0x0

    sput p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->z:I

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p0

    sput-object p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->y:Ljava/lang/Long;

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p0

    sget-object v0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->y:Ljava/lang/Long;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/e;->a(J)V

    sget-object p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->A:Lcom/google/android/gms/ads/InterstitialAd;

    invoke-virtual {p0}, Lcom/google/android/gms/ads/InterstitialAd;->show()V

    :cond_3
    invoke-static {}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->D()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_4
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaReleaseAppActivity;Z)Z
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->t:Z

    return p1
.end method

.method static synthetic b(Lchat/ola/vn/activity/OlaReleaseAppActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->f(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic c(Z)Z
    .locals 0

    sput-boolean p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->B:Z

    return p0
.end method

.method private f(Ljava/lang/String;)V
    .locals 4
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->n:Landroid/widget/VideoView;

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    return-void

    :cond_1
    sget-boolean v0, Lchat/ola/vn/h;->I:Z

    const/16 v1, 0x8

    const/4 v2, 0x0

    if-nez v0, :cond_2

    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->k:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {p1, v2}, Lchat/ola/vn/view/OlaRatioImageView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->l:Landroid/view/View;

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->B()V

    return-void

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->v:Ljava/lang/String;

    invoke-static {v0, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_3

    const/4 v3, 0x0

    if-nez v0, :cond_3

    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->n:Landroid/widget/VideoView;

    invoke-virtual {v0}, Landroid/widget/VideoView;->stopPlayback()V

    iput-object v3, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->v:Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->n:Landroid/widget/VideoView;

    invoke-virtual {v0, v1}, Landroid/widget/VideoView;->setVisibility(I)V

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->n:Landroid/widget/VideoView;

    invoke-virtual {v0}, Landroid/widget/VideoView;->getVisibility()I

    move-result v0

    if-eqz v0, :cond_7

    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->v:Ljava/lang/String;

    invoke-static {v0, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    goto :goto_1

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->m:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaRatioImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->o:Landroid/view/View;

    if-eqz v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->o:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_3

    :cond_5
    :try_start_3
    invoke-static {}, Lcom/mg/ola/common/d/g;->g()Z

    move-result v0

    if-eqz v0, :cond_6

    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->n:Landroid/widget/VideoView;

    invoke-virtual {v0, v3}, Landroid/widget/VideoView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    goto :goto_0

    :cond_6
    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->n:Landroid/widget/VideoView;

    invoke-virtual {v0, v3}, Landroid/widget/VideoView;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    :catch_1
    :goto_0
    :try_start_4
    iput-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->v:Ljava/lang/String;

    new-instance v0, Lchat/ola/vn/x/a;

    invoke-direct {v0}, Lchat/ola/vn/x/a;-><init>()V

    new-instance v1, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;

    invoke-direct {v1, p0}, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;-><init>(Lchat/ola/vn/activity/OlaReleaseAppActivity;)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/x/a;->a(Lchat/ola/vn/x/d;)Lchat/ola/vn/x/a;

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/String;

    aput-object p1, v1, v2

    invoke-virtual {v0, v1}, Lchat/ola/vn/x/a;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_7
    :goto_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->n:Landroid/widget/VideoView;

    invoke-virtual {p1, v2}, Landroid/widget/VideoView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->n:Landroid/widget/VideoView;

    invoke-virtual {p1}, Landroid/widget/VideoView;->isPlaying()Z

    move-result p1

    if-eqz p1, :cond_8

    return-void

    :cond_8
    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->o:Landroid/view/View;

    if-eqz p1, :cond_9

    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->o:Landroid/view/View;

    invoke-virtual {p1, v2}, Landroid/view/View;->setVisibility(I)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_3

    :cond_9
    :try_start_5
    invoke-static {}, Lcom/mg/ola/common/d/g;->g()Z

    move-result p1

    if-eqz p1, :cond_a

    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->n:Landroid/widget/VideoView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->m:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaRatioImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/VideoView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    goto :goto_2

    :cond_a
    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->n:Landroid/widget/VideoView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->m:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaRatioImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/VideoView;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_2

    goto :goto_2

    :catch_2
    :try_start_6
    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->n:Landroid/widget/VideoView;

    invoke-virtual {p1, v2}, Landroid/widget/VideoView;->setBackgroundColor(I)V

    :goto_2
    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->n:Landroid/widget/VideoView;

    invoke-virtual {p1, v2}, Landroid/widget/VideoView;->seekTo(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->n:Landroid/widget/VideoView;

    invoke-virtual {p1}, Landroid/widget/VideoView;->start()V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_3

    :catch_3
    return-void
.end method


# virtual methods
.method public B()V
    .locals 5

    sget-object v0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object v0, v0, Lchat/ola/vn/entity/k;->k:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->k:Lchat/ola/vn/view/OlaRatioImageView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaRatioImageView;->setVisibility(I)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->k:Lchat/ola/vn/view/OlaRatioImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaRatioImageView;->setVisibility(I)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object v1, v1, Lchat/ola/vn/entity/k;->k:Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->k:Lchat/ola/vn/view/OlaRatioImageView;

    iget-object v3, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->p:Landroid/view/View;

    sget v4, Lchat/ola/vn/e;->c:I

    invoke-virtual {v0, v1, v2, v3, v4}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;I)V

    return-void
.end method

.method public C()V
    .locals 3

    sget-object v0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object v0, v0, Lchat/ola/vn/entity/k;->j:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->f:Lchat/ola/vn/view/OlaCachedImageView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->f:Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object v1, v1, Lchat/ola/vn/entity/k;->j:Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->f:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    return-void
.end method

.method protected a()V
    .locals 1

    const/4 v0, 0x0

    :try_start_0
    iput-boolean v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->t:Z

    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->u:Landroid/os/CountDownTimer;

    invoke-virtual {v0}, Landroid/os/CountDownTimer;->start()Landroid/os/CountDownTimer;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onBackPressed()V
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->t:Z

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-super {p0}, Lchat/ola/vn/c;->onBackPressed()V

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f0900be

    if-eq p1, v0, :cond_1

    const v0, 0x7f0900ce

    if-eq p1, v0, :cond_0

    const v0, 0x7f0900d5

    if-eq p1, v0, :cond_0

    const v0, 0x7f0905c4

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->F()V

    return-void

    :cond_1
    iget-boolean p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->t:Z

    if-eqz p1, :cond_2

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 6

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b00b2

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->setContentView(I)V

    const/4 p1, 0x0

    iput-boolean p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->t:Z

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->E()V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->G()V

    new-instance p1, Lchat/ola/vn/activity/OlaReleaseAppActivity$1;

    const-wide/16 v2, 0x1388

    const-wide/16 v4, 0x3e8

    move-object v0, p1

    move-object v1, p0

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/activity/OlaReleaseAppActivity$1;-><init>(Lchat/ola/vn/activity/OlaReleaseAppActivity;JJ)V

    iput-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->u:Landroid/os/CountDownTimer;

    return-void
.end method

.method protected onDestroy()V
    .locals 1

    invoke-super {p0}, Lchat/ola/vn/c;->onDestroy()V

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->u:Landroid/os/CountDownTimer;

    invoke-virtual {v0}, Landroid/os/CountDownTimer;->cancel()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->u:Landroid/os/CountDownTimer;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
