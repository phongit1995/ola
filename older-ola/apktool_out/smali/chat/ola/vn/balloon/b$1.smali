.class Lchat/ola/vn/balloon/b$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/GestureDetector$OnGestureListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/balloon/b;-><init>(Lchat/ola/vn/balloon/OlaBalloonService;II)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/balloon/b;


# direct methods
.method constructor <init>(Lchat/ola/vn/balloon/b;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/balloon/b$1;->a:Lchat/ola/vn/balloon/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onDown(Landroid/view/MotionEvent;)Z
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method public onFling(Landroid/view/MotionEvent;Landroid/view/MotionEvent;FF)Z
    .locals 0

    iget-object p1, p0, Lchat/ola/vn/balloon/b$1;->a:Lchat/ola/vn/balloon/b;

    iget-boolean p1, p1, Lchat/ola/vn/balloon/b;->h:Z

    if-eqz p1, :cond_0

    invoke-static {p3}, Ljava/lang/Math;->abs(F)F

    move-result p1

    goto :goto_0

    :cond_0
    invoke-static {p3}, Ljava/lang/Math;->abs(F)F

    move-result p1

    neg-float p1, p1

    :goto_0
    iget-object p2, p0, Lchat/ola/vn/balloon/b$1;->a:Lchat/ola/vn/balloon/b;

    iget-boolean p2, p2, Lchat/ola/vn/balloon/b;->i:Z

    if-eqz p2, :cond_1

    invoke-static {p4}, Ljava/lang/Math;->abs(F)F

    move-result p2

    goto :goto_1

    :cond_1
    invoke-static {p4}, Ljava/lang/Math;->abs(F)F

    move-result p2

    neg-float p2, p2

    :goto_1
    float-to-int p1, p1

    float-to-int p2, p2

    iget-object p3, p0, Lchat/ola/vn/balloon/b$1;->a:Lchat/ola/vn/balloon/b;

    iget-object p3, p3, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    iget p3, p3, Landroid/view/WindowManager$LayoutParams;->x:I

    add-int/2addr p3, p1

    iget-object p1, p0, Lchat/ola/vn/balloon/b$1;->a:Lchat/ola/vn/balloon/b;

    iget-object p1, p1, Lchat/ola/vn/balloon/b;->b:Landroid/view/WindowManager$LayoutParams;

    iget p1, p1, Landroid/view/WindowManager$LayoutParams;->y:I

    add-int/2addr p1, p2

    iget-object p2, p0, Lchat/ola/vn/balloon/b$1;->a:Lchat/ola/vn/balloon/b;

    const/4 p4, 0x2

    iput-byte p4, p2, Lchat/ola/vn/balloon/b;->a:B

    iget-object p2, p0, Lchat/ola/vn/balloon/b$1;->a:Lchat/ola/vn/balloon/b;

    invoke-static {p2, p3, p1}, Lchat/ola/vn/balloon/b;->a(Lchat/ola/vn/balloon/a;II)[I

    move-result-object p2

    const/4 p4, 0x1

    if-eqz p2, :cond_2

    const/4 p1, 0x0

    aget p3, p2, p1

    aget p1, p2, p4

    :cond_2
    iget-object p2, p0, Lchat/ola/vn/balloon/b$1;->a:Lchat/ola/vn/balloon/b;

    invoke-static {p2, p3, p1}, Lchat/ola/vn/balloon/b;->a(Lchat/ola/vn/balloon/b;II)V

    return p4
.end method

.method public onLongPress(Landroid/view/MotionEvent;)V
    .locals 0

    return-void
.end method

.method public onScroll(Landroid/view/MotionEvent;Landroid/view/MotionEvent;FF)Z
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method public onShowPress(Landroid/view/MotionEvent;)V
    .locals 0

    return-void
.end method

.method public onSingleTapUp(Landroid/view/MotionEvent;)Z
    .locals 0

    const/4 p1, 0x0

    return p1
.end method
