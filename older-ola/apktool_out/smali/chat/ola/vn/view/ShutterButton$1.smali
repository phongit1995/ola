.class Lchat/ola/vn/view/ShutterButton$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/view/ShutterButton;->drawableStateChanged()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Z

.field final synthetic b:Lchat/ola/vn/view/ShutterButton;


# direct methods
.method constructor <init>(Lchat/ola/vn/view/ShutterButton;Z)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/ShutterButton$1;->b:Lchat/ola/vn/view/ShutterButton;

    iput-boolean p2, p0, Lchat/ola/vn/view/ShutterButton$1;->a:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/view/ShutterButton$1;->b:Lchat/ola/vn/view/ShutterButton;

    iget-boolean v1, p0, Lchat/ola/vn/view/ShutterButton$1;->a:Z

    invoke-static {v0, v1}, Lchat/ola/vn/view/ShutterButton;->a(Lchat/ola/vn/view/ShutterButton;Z)V

    return-void
.end method
