.class public Lchat/ola/vn/util/a;
.super Ljava/lang/Object;


# static fields
.field public static a:Z = true

.field public static b:Z = true

.field public static c:Z = true

.field private static d:I = 0x2


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public static a(Landroid/view/View;Landroid/view/LayoutInflater;)Lcom/google/android/gms/ads/AdView;
    .locals 3

    sget v0, Lchat/ola/vn/e;->a:I

    mul-int/lit8 v0, v0, 0x50

    div-int/lit8 v0, v0, 0x64

    const/16 v1, 0x44c

    if-le v0, v1, :cond_0

    const/16 v0, 0x44c

    :cond_0
    mul-int/lit16 v1, v0, 0xaa

    div-int/lit16 v1, v1, 0x168

    const/16 v2, 0x258

    if-le v1, v2, :cond_1

    const/16 v0, 0x4f6

    const/16 v1, 0x258

    :cond_1
    const/16 v2, 0xaa

    if-ge v1, v2, :cond_2

    const/16 v1, 0xaa

    :cond_2
    new-instance v2, Lcom/google/android/gms/ads/AdSize;

    invoke-direct {v2, v0, v1}, Lcom/google/android/gms/ads/AdSize;-><init>(II)V

    const v0, 0x7f09002a

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/FrameLayout;

    new-instance v1, Lcom/google/android/gms/ads/AdView;

    invoke-virtual {p1}, Landroid/view/LayoutInflater;->getContext()Landroid/content/Context;

    move-result-object p1

    invoke-direct {v1, p1}, Lcom/google/android/gms/ads/AdView;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v2}, Lcom/google/android/gms/ads/AdView;->setAdSize(Lcom/google/android/gms/ads/AdSize;)V

    const/4 p1, 0x0

    invoke-static {p1}, Lchat/ola/vn/util/a;->a(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Lcom/google/android/gms/ads/AdView;->setAdUnitId(Ljava/lang/String;)V

    new-instance p1, Landroid/view/ViewGroup$LayoutParams;

    const/4 v2, -0x2

    invoke-direct {p1, v2, v2}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v1, p1}, Lcom/google/android/gms/ads/AdView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    invoke-virtual {p0, v1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    new-instance p0, Lchat/ola/vn/util/a$1;

    invoke-direct {p0}, Lchat/ola/vn/util/a$1;-><init>()V

    invoke-virtual {v1, p0}, Lcom/google/android/gms/ads/AdView;->setAdListener(Lcom/google/android/gms/ads/AdListener;)V

    return-object v1
.end method

.method public static a(I)Ljava/lang/String;
    .locals 2

    sget v0, Lchat/ola/vn/util/a;->d:I

    if-nez v0, :cond_0

    packed-switch p0, :pswitch_data_0

    const-string p0, "ca-app-pub-8198619867953749/7386968413"

    return-object p0

    :pswitch_0
    const-string p0, "ca-app-pub-8198619867953749/5058742112"

    return-object p0

    :pswitch_1
    const-string p0, "ca-app-pub-8198619867953749/7386968413"

    return-object p0

    :cond_0
    sget v0, Lchat/ola/vn/util/a;->d:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    packed-switch p0, :pswitch_data_1

    const-string p0, "ca-app-pub-8198619867953749/9662596202"

    return-object p0

    :pswitch_2
    const-string p0, "ca-app-pub-8198619867953749/5969519935"

    return-object p0

    :pswitch_3
    const-string p0, "ca-app-pub-8198619867953749/9662596202"

    return-object p0

    :cond_1
    packed-switch p0, :pswitch_data_2

    const-string p0, "ca-app-pub-2526638984888811/3737166318"

    return-object p0

    :pswitch_4
    const-string p0, "ca-app-pub-2526638984888811/7784222537"

    return-object p0

    :pswitch_5
    const-string p0, "ca-app-pub-2526638984888811/3737166318"

    return-object p0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_1
        :pswitch_1
        :pswitch_0
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x0
        :pswitch_3
        :pswitch_3
        :pswitch_3
        :pswitch_2
    .end packed-switch

    :pswitch_data_2
    .packed-switch 0x0
        :pswitch_5
        :pswitch_5
        :pswitch_5
        :pswitch_4
    .end packed-switch
.end method

.method public static a()V
    .locals 4

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    const-wide/16 v2, 0x14

    rem-long/2addr v0, v2

    long-to-int v0, v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    sput v0, Lchat/ola/vn/util/a;->d:I

    return-void

    :cond_0
    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    sput v1, Lchat/ola/vn/util/a;->d:I

    return-void

    :cond_1
    const/4 v0, 0x2

    goto :goto_0

    return-void
.end method

.method public static b(Landroid/view/View;Landroid/view/LayoutInflater;)Lcom/google/android/gms/ads/AdView;
    .locals 3

    sget v0, Lchat/ola/vn/e;->a:I

    mul-int/lit8 v0, v0, 0x50

    div-int/lit8 v0, v0, 0x64

    const/16 v1, 0x44c

    if-le v0, v1, :cond_0

    const/16 v0, 0x44c

    :cond_0
    mul-int/lit16 v2, v0, 0xaa

    div-int/lit16 v2, v2, 0x168

    if-le v2, v1, :cond_1

    const/16 v0, 0x919

    goto :goto_0

    :cond_1
    move v1, v2

    :goto_0
    const/16 v2, 0xaa

    if-ge v1, v2, :cond_2

    const/16 v1, 0xaa

    :cond_2
    new-instance v2, Lcom/google/android/gms/ads/AdSize;

    invoke-direct {v2, v0, v1}, Lcom/google/android/gms/ads/AdSize;-><init>(II)V

    const v0, 0x7f09002a

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/FrameLayout;

    new-instance v1, Lcom/google/android/gms/ads/AdView;

    invoke-virtual {p1}, Landroid/view/LayoutInflater;->getContext()Landroid/content/Context;

    move-result-object p1

    invoke-direct {v1, p1}, Lcom/google/android/gms/ads/AdView;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v2}, Lcom/google/android/gms/ads/AdView;->setAdSize(Lcom/google/android/gms/ads/AdSize;)V

    const/4 p1, 0x1

    invoke-static {p1}, Lchat/ola/vn/util/a;->a(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Lcom/google/android/gms/ads/AdView;->setAdUnitId(Ljava/lang/String;)V

    new-instance p1, Landroid/view/ViewGroup$LayoutParams;

    const/4 v2, -0x2

    invoke-direct {p1, v2, v2}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v1, p1}, Lcom/google/android/gms/ads/AdView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    invoke-virtual {p0, v1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    new-instance p0, Lchat/ola/vn/util/a$2;

    invoke-direct {p0}, Lchat/ola/vn/util/a$2;-><init>()V

    invoke-virtual {v1, p0}, Lcom/google/android/gms/ads/AdView;->setAdListener(Lcom/google/android/gms/ads/AdListener;)V

    return-object v1
.end method

.method public static b()Ljava/lang/String;
    .locals 2

    sget v0, Lchat/ola/vn/util/a;->d:I

    if-nez v0, :cond_0

    const-string v0, "ca-app-pub-8198619867953749~1182874111"

    return-object v0

    :cond_0
    sget v0, Lchat/ola/vn/util/a;->d:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    const-string v0, "ca-app-pub-8198619867953749~6192759835"

    return-object v0

    :cond_1
    const-string v0, "ca-app-pub-2526638984888811~8989492996"

    return-object v0
.end method

.method public static c(Landroid/view/View;Landroid/view/LayoutInflater;)Lcom/google/android/gms/ads/AdView;
    .locals 4

    sget v0, Lchat/ola/vn/e;->a:I

    mul-int/lit8 v0, v0, 0x55

    div-int/lit8 v0, v0, 0x64

    const/16 v1, 0x44c

    if-le v0, v1, :cond_0

    const/16 v0, 0x44c

    :cond_0
    mul-int/lit16 v2, v0, 0x14a

    div-int/lit16 v2, v2, 0x168

    if-le v2, v1, :cond_1

    const/16 v0, 0x4b0

    goto :goto_0

    :cond_1
    move v1, v2

    :goto_0
    const/16 v2, 0x14a

    if-ge v1, v2, :cond_2

    const/16 v1, 0x14a

    :cond_2
    new-instance v2, Lcom/google/android/gms/ads/AdSize;

    invoke-direct {v2, v0, v1}, Lcom/google/android/gms/ads/AdSize;-><init>(II)V

    const v0, 0x7f09002a

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/FrameLayout;

    new-instance v1, Lcom/google/android/gms/ads/AdView;

    invoke-virtual {p1}, Landroid/view/LayoutInflater;->getContext()Landroid/content/Context;

    move-result-object p1

    invoke-direct {v1, p1}, Lcom/google/android/gms/ads/AdView;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v2}, Lcom/google/android/gms/ads/AdView;->setAdSize(Lcom/google/android/gms/ads/AdSize;)V

    const/4 p1, 0x2

    invoke-static {p1}, Lchat/ola/vn/util/a;->a(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Lcom/google/android/gms/ads/AdView;->setAdUnitId(Ljava/lang/String;)V

    new-instance p1, Landroid/view/ViewGroup$LayoutParams;

    const/4 v2, -0x1

    const/4 v3, -0x2

    invoke-direct {p1, v2, v3}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v1, p1}, Lcom/google/android/gms/ads/AdView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    invoke-virtual {p0, v1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    new-instance p0, Lchat/ola/vn/util/a$3;

    invoke-direct {p0}, Lchat/ola/vn/util/a$3;-><init>()V

    invoke-virtual {v1, p0}, Lcom/google/android/gms/ads/AdView;->setAdListener(Lcom/google/android/gms/ads/AdListener;)V

    return-object v1
.end method
