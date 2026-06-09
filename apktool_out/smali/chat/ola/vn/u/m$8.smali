.class Lchat/ola/vn/u/m$8;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/u/m;->a(II)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:I

.field final synthetic b:I

.field final synthetic c:Lchat/ola/vn/u/m;


# direct methods
.method constructor <init>(Lchat/ola/vn/u/m;II)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/u/m$8;->c:Lchat/ola/vn/u/m;

    iput p2, p0, Lchat/ola/vn/u/m$8;->a:I

    iput p3, p0, Lchat/ola/vn/u/m$8;->b:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    :try_start_0
    iget v0, p0, Lchat/ola/vn/u/m$8;->a:I

    if-lez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/u/m$8;->c:Lchat/ola/vn/u/m;

    iget-object v0, v0, Lchat/ola/vn/u/m;->d:Lchat/ola/vn/u/p;

    invoke-virtual {v0}, Lchat/ola/vn/u/p;->c()Lchat/ola/vn/u/o;

    move-result-object v0

    iget v1, p0, Lchat/ola/vn/u/m$8;->b:I

    iget v2, p0, Lchat/ola/vn/u/m$8;->a:I

    invoke-interface {v0, v1, v2}, Lchat/ola/vn/u/o;->a(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method
