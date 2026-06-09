.class Lchat/ola/vn/m/y$11;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/SeekBar$OnSeekBarChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/y;->v()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/y;

.field private b:Ljava/lang/Runnable;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/y;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/y$11;->a:Lchat/ola/vn/m/y;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/y$11;Ljava/lang/Runnable;)Ljava/lang/Runnable;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/y$11;->b:Ljava/lang/Runnable;

    return-object p1
.end method


# virtual methods
.method public onProgressChanged(Landroid/widget/SeekBar;IZ)V
    .locals 2

    if-eqz p3, :cond_1

    iget-object p3, p0, Lchat/ola/vn/m/y$11;->b:Ljava/lang/Runnable;

    if-eqz p3, :cond_0

    iget-object p3, p0, Lchat/ola/vn/m/y$11;->b:Ljava/lang/Runnable;

    invoke-virtual {p1, p3}, Landroid/widget/SeekBar;->removeCallbacks(Ljava/lang/Runnable;)Z

    const/4 p3, 0x0

    iput-object p3, p0, Lchat/ola/vn/m/y$11;->b:Ljava/lang/Runnable;

    :cond_0
    new-instance p3, Lchat/ola/vn/m/y$11$1;

    invoke-direct {p3, p0, p2}, Lchat/ola/vn/m/y$11$1;-><init>(Lchat/ola/vn/m/y$11;I)V

    iput-object p3, p0, Lchat/ola/vn/m/y$11;->b:Ljava/lang/Runnable;

    iget-object p2, p0, Lchat/ola/vn/m/y$11;->b:Ljava/lang/Runnable;

    const-wide/16 v0, 0x1f4

    invoke-virtual {p1, p2, v0, v1}, Landroid/widget/SeekBar;->postDelayed(Ljava/lang/Runnable;J)Z

    :cond_1
    return-void
.end method

.method public onStartTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 0

    return-void
.end method

.method public onStopTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 0

    invoke-static {}, Lchat/ola/vn/c/x;->h()V

    return-void
.end method
