.class Lchat/ola/vn/m/y$11$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/y$11;->onProgressChanged(Landroid/widget/SeekBar;IZ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:I

.field final synthetic b:Lchat/ola/vn/m/y$11;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/y$11;I)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/y$11$1;->b:Lchat/ola/vn/m/y$11;

    iput p2, p0, Lchat/ola/vn/m/y$11$1;->a:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget v0, p0, Lchat/ola/vn/m/y$11$1;->a:I

    sput v0, Lchat/ola/vn/c/x;->i:I

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    sget v1, Lchat/ola/vn/c/x;->i:I

    invoke-virtual {v0, v1}, Lchat/ola/vn/e;->b(I)V

    iget-object v0, p0, Lchat/ola/vn/m/y$11$1;->b:Lchat/ola/vn/m/y$11;

    iget-object v0, v0, Lchat/ola/vn/m/y$11;->a:Lchat/ola/vn/m/y;

    invoke-static {v0}, Lchat/ola/vn/m/y;->c(Lchat/ola/vn/m/y;)Lchat/ola/vn/b/ah;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/m/y$11$1;->b:Lchat/ola/vn/m/y$11;

    iget-object v1, v1, Lchat/ola/vn/m/y$11;->a:Lchat/ola/vn/m/y;

    invoke-static {v1}, Lchat/ola/vn/m/y;->b(Lchat/ola/vn/m/y;)F

    move-result v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/ah;->a(F)V

    iget-object v0, p0, Lchat/ola/vn/m/y$11$1;->b:Lchat/ola/vn/m/y$11;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/m/y$11;->a(Lchat/ola/vn/m/y$11;Ljava/lang/Runnable;)Ljava/lang/Runnable;

    return-void
.end method
