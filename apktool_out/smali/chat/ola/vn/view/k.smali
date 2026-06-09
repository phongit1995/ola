.class public Lchat/ola/vn/view/k;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/support/v4/view/ViewPager$PageTransformer;


# static fields
.field private static a:F = 0.75f


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public transformPage(Landroid/view/View;F)V
    .locals 4
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    invoke-virtual {p1}, Landroid/view/View;->getWidth()I

    move-result v0

    const/high16 v1, -0x40800000    # -1.0f

    cmpg-float v1, p2, v1

    const/4 v2, 0x0

    if-gez v1, :cond_1

    :cond_0
    invoke-virtual {p1, v2}, Landroid/view/View;->setAlpha(F)V

    return-void

    :cond_1
    cmpg-float v1, p2, v2

    const/high16 v3, 0x3f800000    # 1.0f

    if-gtz v1, :cond_2

    invoke-virtual {p1, v3}, Landroid/view/View;->setAlpha(F)V

    invoke-virtual {p1, v2}, Landroid/view/View;->setTranslationX(F)V

    invoke-virtual {p1, v3}, Landroid/view/View;->setScaleX(F)V

    invoke-virtual {p1, v3}, Landroid/view/View;->setScaleY(F)V

    return-void

    :cond_2
    cmpg-float v1, p2, v3

    if-gtz v1, :cond_0

    sub-float v1, v3, p2

    invoke-virtual {p1, v1}, Landroid/view/View;->setAlpha(F)V

    int-to-float v0, v0

    neg-float v1, p2

    mul-float v0, v0, v1

    invoke-virtual {p1, v0}, Landroid/view/View;->setTranslationX(F)V

    sget v0, Lchat/ola/vn/view/k;->a:F

    sget v1, Lchat/ola/vn/view/k;->a:F

    sub-float v1, v3, v1

    invoke-static {p2}, Ljava/lang/Math;->abs(F)F

    move-result p2

    sub-float/2addr v3, p2

    mul-float v1, v1, v3

    add-float/2addr v0, v1

    invoke-virtual {p1, v0}, Landroid/view/View;->setScaleX(F)V

    invoke-virtual {p1, v0}, Landroid/view/View;->setScaleY(F)V

    return-void
.end method
