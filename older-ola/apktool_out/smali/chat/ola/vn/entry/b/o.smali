.class public Lchat/ola/vn/entry/b/o;
.super Lchat/ola/vn/entry/b/l;


# instance fields
.field private a:Lchat/ola/vn/view/OlaRatioImageView;

.field private e:Landroid/widget/ProgressBar;

.field private f:Landroid/widget/TextView;

.field private g:Ljava/lang/String;


# direct methods
.method public constructor <init>(Landroid/view/View;)V
    .locals 1

    invoke-direct {p0, p1}, Lchat/ola/vn/entry/b/l;-><init>(Landroid/view/View;)V

    const v0, 0x7f09029e

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaRatioImageView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/o;->a:Lchat/ola/vn/view/OlaRatioImageView;

    const v0, 0x7f09036b

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ProgressBar;

    iput-object v0, p0, Lchat/ola/vn/entry/b/o;->e:Landroid/widget/ProgressBar;

    const v0, 0x7f09056d

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/entry/b/o;->f:Landroid/widget/TextView;

    return-void
.end method

.method private a(Ljava/lang/CharSequence;)V
    .locals 3

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/entry/b/o;->a:Lchat/ola/vn/view/OlaRatioImageView;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaRatioImageView;->setVisibility(I)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/o;->a:Lchat/ola/vn/view/OlaRatioImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaRatioImageView;->setVisibility(I)V

    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/entry/b/o;->g:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/entry/b/o;->g:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/o;->g(Ljava/lang/String;)S

    move-result p1

    const v0, 0x7f080717

    packed-switch p1, :pswitch_data_0

    iget-object p1, p0, Lchat/ola/vn/entry/b/o;->a:Lchat/ola/vn/view/OlaRatioImageView;

    sget-object v0, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaRatioImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/entry/b/o;->g:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/entry/b/o;->a:Lchat/ola/vn/view/OlaRatioImageView;

    iget-object v2, p0, Lchat/ola/vn/entry/b/o;->e:Landroid/widget/ProgressBar;

    invoke-virtual {p1, v0, v1, v2}, Lchat/ola/vn/c/t;->c(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;)V

    return-void

    :pswitch_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/o;->a:Lchat/ola/vn/view/OlaRatioImageView;

    sget-object v1, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p1, v1}, Lchat/ola/vn/view/OlaRatioImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/o;->a:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaRatioImageView;->setImageResource(I)V

    return-void

    :pswitch_1
    iget-object p1, p0, Lchat/ola/vn/entry/b/o;->a:Lchat/ola/vn/view/OlaRatioImageView;

    sget-object v1, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p1, v1}, Lchat/ola/vn/view/OlaRatioImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/o;->a:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaRatioImageView;->setImageResource(I)V

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method


# virtual methods
.method public a(Lchat/ola/vn/entry/c;I)V
    .locals 2

    invoke-virtual {p1}, Lchat/ola/vn/entry/c;->e()Ljava/lang/CharSequence;

    move-result-object p2

    if-eqz p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/entry/b/o;->f:Landroid/widget/TextView;

    invoke-virtual {p1}, Lchat/ola/vn/entry/c;->e()Ljava/lang/CharSequence;

    move-result-object v0

    :goto_0
    invoke-virtual {p2, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_1

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/entry/b/o;->f:Landroid/widget/TextView;

    const-string v0, ""

    goto :goto_0

    :goto_1
    iget-object p2, p0, Lchat/ola/vn/entry/b/o;->f:Landroid/widget/TextView;

    const/4 v0, 0x2

    iget v1, p0, Lchat/ola/vn/entry/b/o;->d:F

    invoke-virtual {p2, v0, v1}, Landroid/widget/TextView;->setTextSize(IF)V

    iget-object p2, p0, Lchat/ola/vn/entry/b/o;->a:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {p2, p1}, Lchat/ola/vn/view/OlaRatioImageView;->setTag(Ljava/lang/Object;)V

    iget-object p2, p0, Lchat/ola/vn/entry/b/o;->a:Lchat/ola/vn/view/OlaRatioImageView;

    iget-object v0, p0, Lchat/ola/vn/entry/b/o;->b:Landroid/view/View$OnClickListener;

    invoke-virtual {p2, v0}, Lchat/ola/vn/view/OlaRatioImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-virtual {p1}, Lchat/ola/vn/entry/c;->d()Ljava/lang/CharSequence;

    move-result-object p1

    invoke-direct {p0, p1}, Lchat/ola/vn/entry/b/o;->a(Ljava/lang/CharSequence;)V

    return-void
.end method
