.class Lchat/ola/vn/view/SlidingPaneLayout$g;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/view/SlidingPaneLayout$f;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/view/SlidingPaneLayout;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "g"
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/view/SlidingPaneLayout;Landroid/view/View;)V
    .locals 3

    invoke-virtual {p2}, Landroid/view/View;->getLeft()I

    move-result v0

    invoke-virtual {p2}, Landroid/view/View;->getTop()I

    move-result v1

    invoke-virtual {p2}, Landroid/view/View;->getRight()I

    move-result v2

    invoke-virtual {p2}, Landroid/view/View;->getBottom()I

    move-result p2

    invoke-static {p1, v0, v1, v2, p2}, Landroid/support/v4/view/ViewCompat;->postInvalidateOnAnimation(Landroid/view/View;IIII)V

    return-void
.end method
