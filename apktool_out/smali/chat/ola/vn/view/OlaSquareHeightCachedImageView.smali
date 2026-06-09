.class public Lchat/ola/vn/view/OlaSquareHeightCachedImageView;
.super Lchat/ola/vn/view/OlaCachedImageView;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/view/OlaCachedImageView;-><init>(Landroid/content/Context;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/view/OlaCachedImageView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lchat/ola/vn/view/OlaCachedImageView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    return-void
.end method


# virtual methods
.method protected onMeasure(II)V
    .locals 0

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaSquareHeightCachedImageView;->getSuggestedMinimumHeight()I

    move-result p1

    invoke-static {p1, p2}, Lchat/ola/vn/view/OlaSquareHeightCachedImageView;->getDefaultSize(II)I

    move-result p1

    invoke-virtual {p0, p1, p1}, Lchat/ola/vn/view/OlaSquareHeightCachedImageView;->setMeasuredDimension(II)V

    return-void
.end method

.method protected onSizeChanged(IIII)V
    .locals 0

    invoke-super {p0, p2, p2, p3, p4}, Lchat/ola/vn/view/OlaCachedImageView;->onSizeChanged(IIII)V

    return-void
.end method
