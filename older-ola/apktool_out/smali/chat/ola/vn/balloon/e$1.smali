.class Lchat/ola/vn/balloon/e$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/balloon/e;->f()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/balloon/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/balloon/e;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/balloon/e$1;->a:Lchat/ola/vn/balloon/e;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    iget-object v0, p0, Lchat/ola/vn/balloon/e$1;->a:Lchat/ola/vn/balloon/e;

    invoke-static {v0}, Lchat/ola/vn/balloon/e;->a(Lchat/ola/vn/balloon/e;)V

    iget-object v0, p0, Lchat/ola/vn/balloon/e$1;->a:Lchat/ola/vn/balloon/e;

    iget-object v0, v0, Lchat/ola/vn/balloon/e;->q:Lchat/ola/vn/balloon/OlaBalloonService;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/balloon/e$1;->a:Lchat/ola/vn/balloon/e;

    const/4 v1, 0x1

    iput-byte v1, v0, Lchat/ola/vn/balloon/e;->a:B

    iget-object v0, p0, Lchat/ola/vn/balloon/e$1;->a:Lchat/ola/vn/balloon/e;

    iget v0, v0, Lchat/ola/vn/balloon/e;->n:I

    if-ltz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/balloon/e$1;->a:Lchat/ola/vn/balloon/e;

    iget v0, v0, Lchat/ola/vn/balloon/e;->o:I

    if-ltz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/balloon/e$1;->a:Lchat/ola/vn/balloon/e;

    iget-object v0, v0, Lchat/ola/vn/balloon/e;->q:Lchat/ola/vn/balloon/OlaBalloonService;

    iget-object v1, p0, Lchat/ola/vn/balloon/e$1;->a:Lchat/ola/vn/balloon/e;

    iget-object v2, p0, Lchat/ola/vn/balloon/e$1;->a:Lchat/ola/vn/balloon/e;

    iget-object v2, v2, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    iget-object v3, p0, Lchat/ola/vn/balloon/e$1;->a:Lchat/ola/vn/balloon/e;

    iget v3, v3, Lchat/ola/vn/balloon/e;->n:I

    iget-object v4, p0, Lchat/ola/vn/balloon/e$1;->a:Lchat/ola/vn/balloon/e;

    iget v4, v4, Lchat/ola/vn/balloon/e;->o:I

    invoke-virtual {v0, v1, v2, v3, v4}, Lchat/ola/vn/balloon/OlaBalloonService;->a(Lchat/ola/vn/balloon/a;Landroid/view/WindowManager$LayoutParams;II)V

    iget-object v0, p0, Lchat/ola/vn/balloon/e$1;->a:Lchat/ola/vn/balloon/e;

    const/4 v1, -0x1

    iput v1, v0, Lchat/ola/vn/balloon/e;->n:I

    iget-object v0, p0, Lchat/ola/vn/balloon/e$1;->a:Lchat/ola/vn/balloon/e;

    iput v1, v0, Lchat/ola/vn/balloon/e;->o:I

    :cond_0
    return-void
.end method
