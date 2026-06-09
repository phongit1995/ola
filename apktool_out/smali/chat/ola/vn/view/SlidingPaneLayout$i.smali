.class Lchat/ola/vn/view/SlidingPaneLayout$i;
.super Lchat/ola/vn/view/SlidingPaneLayout$g;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/view/SlidingPaneLayout;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "i"
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/view/SlidingPaneLayout$g;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/view/SlidingPaneLayout;Landroid/view/View;)V
    .locals 0

    invoke-virtual {p2}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/SlidingPaneLayout$d;

    iget-object p1, p1, Lchat/ola/vn/view/SlidingPaneLayout$d;->d:Landroid/graphics/Paint;

    invoke-static {p2, p1}, Landroid/support/v4/view/ViewCompat;->setLayerPaint(Landroid/view/View;Landroid/graphics/Paint;)V

    return-void
.end method
