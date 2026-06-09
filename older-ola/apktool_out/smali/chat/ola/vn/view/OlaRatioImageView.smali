.class public Lchat/ola/vn/view/OlaRatioImageView;
.super Lchat/ola/vn/view/OlaCachedImageView;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;
    }
.end annotation


# instance fields
.field private e:Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;

.field private f:D


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 2

    invoke-direct {p0, p1}, Lchat/ola/vn/view/OlaCachedImageView;-><init>(Landroid/content/Context;)V

    sget-object p1, Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;->a:Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;

    iput-object p1, p0, Lchat/ola/vn/view/OlaRatioImageView;->e:Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;

    const-wide v0, 0x3ffc71c71c71c71cL    # 1.7777777777777777

    iput-wide v0, p0, Lchat/ola/vn/view/OlaRatioImageView;->f:D

    invoke-direct {p0}, Lchat/ola/vn/view/OlaRatioImageView;->a()V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/view/OlaCachedImageView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    sget-object p1, Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;->a:Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;

    iput-object p1, p0, Lchat/ola/vn/view/OlaRatioImageView;->e:Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;

    const-wide p1, 0x3ffc71c71c71c71cL    # 1.7777777777777777

    iput-wide p1, p0, Lchat/ola/vn/view/OlaRatioImageView;->f:D

    invoke-direct {p0}, Lchat/ola/vn/view/OlaRatioImageView;->a()V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lchat/ola/vn/view/OlaCachedImageView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    sget-object p1, Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;->a:Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;

    iput-object p1, p0, Lchat/ola/vn/view/OlaRatioImageView;->e:Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;

    const-wide p1, 0x3ffc71c71c71c71cL    # 1.7777777777777777

    iput-wide p1, p0, Lchat/ola/vn/view/OlaRatioImageView;->f:D

    invoke-direct {p0}, Lchat/ola/vn/view/OlaRatioImageView;->a()V

    return-void
.end method

.method private a()V
    .locals 0

    return-void
.end method


# virtual methods
.method protected onMeasure(II)V
    .locals 5
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    iget-wide v0, p0, Lchat/ola/vn/view/OlaRatioImageView;->f:D

    const-wide/16 v2, 0x0

    cmpl-double v4, v0, v2

    if-eqz v4, :cond_3

    invoke-static {p1}, Landroid/view/View$MeasureSpec;->getSize(I)I

    move-result p1

    invoke-static {p2}, Landroid/view/View$MeasureSpec;->getSize(I)I

    move-result p2

    sget-object v0, Lchat/ola/vn/view/OlaRatioImageView$1;->a:[I

    iget-object v1, p0, Lchat/ola/vn/view/OlaRatioImageView;->e:Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;

    invoke-virtual {v1}, Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;->ordinal()I

    move-result v1

    aget v0, v0, v1

    packed-switch v0, :pswitch_data_0

    goto :goto_2

    :pswitch_0
    int-to-double v0, p2

    iget-wide v2, p0, Lchat/ola/vn/view/OlaRatioImageView;->f:D

    mul-double v0, v0, v2

    double-to-int p1, v0

    invoke-static {}, Lcom/mg/ola/common/d/g;->g()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaRatioImageView;->getMaxWidth()I

    move-result v0

    goto :goto_0

    :cond_0
    iget v0, p0, Lchat/ola/vn/view/OlaRatioImageView;->c:I

    :goto_0
    if-le p1, v0, :cond_2

    if-lez v0, :cond_2

    move p1, v0

    goto :goto_2

    :pswitch_1
    int-to-double v0, p1

    iget-wide v2, p0, Lchat/ola/vn/view/OlaRatioImageView;->f:D

    div-double/2addr v0, v2

    double-to-int p2, v0

    invoke-static {}, Lcom/mg/ola/common/d/g;->g()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaRatioImageView;->getMaxHeight()I

    move-result v0

    goto :goto_1

    :cond_1
    iget v0, p0, Lchat/ola/vn/view/OlaRatioImageView;->d:I

    :goto_1
    if-le p2, v0, :cond_2

    if-lez v0, :cond_2

    move p2, v0

    :cond_2
    :goto_2
    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/view/OlaRatioImageView;->setMeasuredDimension(II)V

    return-void

    :cond_3
    invoke-super {p0, p1, p2}, Lchat/ola/vn/view/OlaCachedImageView;->onMeasure(II)V

    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public setBaseOrientation(Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/OlaRatioImageView;->e:Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaRatioImageView;->requestLayout()V

    return-void
.end method

.method public setRatio(D)V
    .locals 3

    iget-wide v0, p0, Lchat/ola/vn/view/OlaRatioImageView;->f:D

    cmpl-double v2, v0, p1

    if-eqz v2, :cond_0

    iput-wide p1, p0, Lchat/ola/vn/view/OlaRatioImageView;->f:D

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaRatioImageView;->requestLayout()V

    :cond_0
    return-void
.end method
