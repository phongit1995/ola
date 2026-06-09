.class public abstract Lchat/ola/vn/entry/b/l;
.super Ljava/lang/Object;


# instance fields
.field protected b:Landroid/view/View$OnClickListener;

.field protected c:Landroid/view/View$OnLongClickListener;

.field protected d:F


# direct methods
.method public constructor <init>(Landroid/view/View;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-virtual {p1, p0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    return-void
.end method

.method public static a(Landroid/content/Context;Landroid/view/LayoutInflater;Lchat/ola/vn/entry/c;I)Landroid/view/View;
    .locals 4

    const/4 p2, 0x0

    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f070141

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v0

    const v1, 0x7f0b011a

    const/4 v2, 0x0

    packed-switch p3, :pswitch_data_0

    move-object p0, p2

    goto/16 :goto_1

    :pswitch_0
    const p0, 0x7f0b0117

    invoke-virtual {p1, p0, p2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    :try_start_1
    invoke-virtual {p0, v0, v0, v0, v2}, Landroid/view/View;->setPadding(IIII)V

    new-instance p1, Lchat/ola/vn/entry/b/n;

    invoke-direct {p1, p0}, Lchat/ola/vn/entry/b/n;-><init>(Landroid/view/View;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    goto/16 :goto_1

    :pswitch_1
    const p0, 0x7f0b0112

    :try_start_2
    invoke-virtual {p1, p0, p2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p0
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :try_start_3
    invoke-static {p0, p1}, Lchat/ola/vn/util/a;->c(Landroid/view/View;Landroid/view/LayoutInflater;)Lcom/google/android/gms/ads/AdView;

    invoke-virtual {p0, v0, v0, v0, v2}, Landroid/view/View;->setPadding(IIII)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_1

    :pswitch_2
    const p0, 0x7f0b0113

    :try_start_4
    invoke-virtual {p1, p0, p2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p0
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    :try_start_5
    new-instance p1, Lchat/ola/vn/entry/b/m;

    invoke-direct {p1, p0}, Lchat/ola/vn/entry/b/m;-><init>(Landroid/view/View;)V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_1

    goto :goto_1

    :pswitch_3
    :try_start_6
    new-instance p1, Lcom/mg/ola/common/widget/OlaTextView;

    invoke-direct {p1, p0}, Lcom/mg/ola/common/widget/OlaTextView;-><init>(Landroid/content/Context;)V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_2

    :try_start_7
    invoke-virtual {p1, v0, v0, v0, v2}, Landroid/view/View;->setPadding(IIII)V

    move-object p0, p1

    check-cast p0, Lcom/mg/ola/common/widget/OlaTextView;

    invoke-static {}, Lchat/ola/vn/q/a;->a()Lchat/ola/vn/q/a;

    move-result-object p2

    invoke-virtual {p0, p2}, Lcom/mg/ola/common/widget/OlaTextView;->setOlaSpanClickListener(Lcom/mg/ola/common/widget/OlaTextView$b;)V

    new-instance p0, Lchat/ola/vn/entry/b/k;

    invoke-direct {p0, p1}, Lchat/ola/vn/entry/b/k;-><init>(Landroid/view/View;)V
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_0

    move-object p0, p1

    goto :goto_1

    :catch_0
    move-exception p0

    move-object v3, p1

    move-object p1, p0

    move-object p0, v3

    goto :goto_0

    :pswitch_4
    :try_start_8
    invoke-virtual {p1, v1, p2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p0
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_2

    :try_start_9
    invoke-virtual {p0, v0, v0, v0, v2}, Landroid/view/View;->setPadding(IIII)V

    new-instance p1, Lchat/ola/vn/entry/b/p;

    invoke-direct {p1, p0}, Lchat/ola/vn/entry/b/p;-><init>(Landroid/view/View;)V
    :try_end_9
    .catch Ljava/lang/Throwable; {:try_start_9 .. :try_end_9} :catch_1

    goto :goto_1

    :pswitch_5
    :try_start_a
    invoke-virtual {p1, v1, p2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p0
    :try_end_a
    .catch Ljava/lang/Throwable; {:try_start_a .. :try_end_a} :catch_2

    :try_start_b
    new-instance p1, Lchat/ola/vn/entry/b/q;

    invoke-direct {p1, p0}, Lchat/ola/vn/entry/b/q;-><init>(Landroid/view/View;)V
    :try_end_b
    .catch Ljava/lang/Throwable; {:try_start_b .. :try_end_b} :catch_1

    goto :goto_1

    :pswitch_6
    const p0, 0x7f0b0118

    :try_start_c
    invoke-virtual {p1, p0, p2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p0
    :try_end_c
    .catch Ljava/lang/Throwable; {:try_start_c .. :try_end_c} :catch_2

    :try_start_d
    invoke-virtual {p0, v0, v0, v0, v2}, Landroid/view/View;->setPadding(IIII)V

    new-instance p1, Lchat/ola/vn/entry/b/o;

    invoke-direct {p1, p0}, Lchat/ola/vn/entry/b/o;-><init>(Landroid/view/View;)V
    :try_end_d
    .catch Ljava/lang/Throwable; {:try_start_d .. :try_end_d} :catch_1

    goto :goto_1

    :catch_1
    move-exception p1

    goto :goto_0

    :catch_2
    move-exception p1

    move-object p0, p2

    :goto_0
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :goto_1
    sget p1, Lchat/ola/vn/f;->g:I

    invoke-virtual {p0, p1}, Landroid/view/View;->setBackgroundColor(I)V

    return-object p0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method


# virtual methods
.method public a(F)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/entry/b/l;->d:F

    return-void
.end method

.method public a(Landroid/view/View$OnClickListener;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/l;->b:Landroid/view/View$OnClickListener;

    return-void
.end method

.method public a(Landroid/view/View$OnLongClickListener;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/l;->c:Landroid/view/View$OnLongClickListener;

    return-void
.end method

.method public abstract a(Lchat/ola/vn/entry/c;I)V
.end method
