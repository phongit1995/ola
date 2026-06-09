.class public Lchat/ola/vn/view/RatioFrameLayout;
.super Landroid/widget/FrameLayout;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/view/RatioFrameLayout$BASE_SIDE;
    }
.end annotation


# instance fields
.field private a:Lchat/ola/vn/view/RatioFrameLayout$BASE_SIDE;

.field private b:D


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 2

    invoke-direct {p0, p1}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    sget-object p1, Lchat/ola/vn/view/RatioFrameLayout$BASE_SIDE;->a:Lchat/ola/vn/view/RatioFrameLayout$BASE_SIDE;

    iput-object p1, p0, Lchat/ola/vn/view/RatioFrameLayout;->a:Lchat/ola/vn/view/RatioFrameLayout$BASE_SIDE;

    const-wide v0, 0x3ffc71c71c71c71cL    # 1.7777777777777777

    iput-wide v0, p0, Lchat/ola/vn/view/RatioFrameLayout;->b:D

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    sget-object p1, Lchat/ola/vn/view/RatioFrameLayout$BASE_SIDE;->a:Lchat/ola/vn/view/RatioFrameLayout$BASE_SIDE;

    iput-object p1, p0, Lchat/ola/vn/view/RatioFrameLayout;->a:Lchat/ola/vn/view/RatioFrameLayout$BASE_SIDE;

    const-wide p1, 0x3ffc71c71c71c71cL    # 1.7777777777777777

    iput-wide p1, p0, Lchat/ola/vn/view/RatioFrameLayout;->b:D

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    sget-object p1, Lchat/ola/vn/view/RatioFrameLayout$BASE_SIDE;->a:Lchat/ola/vn/view/RatioFrameLayout$BASE_SIDE;

    iput-object p1, p0, Lchat/ola/vn/view/RatioFrameLayout;->a:Lchat/ola/vn/view/RatioFrameLayout$BASE_SIDE;

    const-wide p1, 0x3ffc71c71c71c71cL    # 1.7777777777777777

    iput-wide p1, p0, Lchat/ola/vn/view/RatioFrameLayout;->b:D

    return-void
.end method


# virtual methods
.method protected onMeasure(II)V
    .locals 5

    iget-wide v0, p0, Lchat/ola/vn/view/RatioFrameLayout;->b:D

    const-wide/16 v2, 0x0

    cmpl-double v4, v0, v2

    if-eqz v4, :cond_0

    invoke-static {p1}, Landroid/view/View$MeasureSpec;->getSize(I)I

    move-result p1

    invoke-static {p2}, Landroid/view/View$MeasureSpec;->getSize(I)I

    move-result p2

    sget-object v0, Lchat/ola/vn/view/RatioFrameLayout$1;->a:[I

    iget-object v1, p0, Lchat/ola/vn/view/RatioFrameLayout;->a:Lchat/ola/vn/view/RatioFrameLayout$BASE_SIDE;

    invoke-virtual {v1}, Lchat/ola/vn/view/RatioFrameLayout$BASE_SIDE;->ordinal()I

    move-result v1

    aget v0, v0, v1

    packed-switch v0, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    int-to-double v0, p2

    iget-wide v2, p0, Lchat/ola/vn/view/RatioFrameLayout;->b:D

    mul-double v0, v0, v2

    double-to-int p1, v0

    goto :goto_0

    :pswitch_1
    int-to-double v0, p1

    iget-wide v2, p0, Lchat/ola/vn/view/RatioFrameLayout;->b:D

    div-double/2addr v0, v2

    double-to-int p2, v0

    :goto_0
    const/high16 v0, 0x40000000    # 2.0f

    invoke-static {p1, v0}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result p1

    invoke-static {p2, v0}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result p2

    :cond_0
    invoke-super {p0, p1, p2}, Landroid/widget/FrameLayout;->onMeasure(II)V

    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public setBaseOrientation(Lchat/ola/vn/view/RatioFrameLayout$BASE_SIDE;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/RatioFrameLayout;->a:Lchat/ola/vn/view/RatioFrameLayout$BASE_SIDE;

    invoke-virtual {p0}, Lchat/ola/vn/view/RatioFrameLayout;->requestLayout()V

    return-void
.end method

.method public setRatio(D)V
    .locals 0

    iput-wide p1, p0, Lchat/ola/vn/view/RatioFrameLayout;->b:D

    invoke-virtual {p0}, Lchat/ola/vn/view/RatioFrameLayout;->requestLayout()V

    return-void
.end method
