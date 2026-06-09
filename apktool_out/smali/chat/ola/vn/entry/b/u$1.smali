.class Lchat/ola/vn/entry/b/u$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/n/b$a;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entry/b/u;->g()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/message/k;

.field final synthetic b:Lchat/ola/vn/entry/b/u;


# direct methods
.method constructor <init>(Lchat/ola/vn/entry/b/u;Lchat/ola/vn/message/k;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/u$1;->b:Lchat/ola/vn/entry/b/u;

    iput-object p2, p0, Lchat/ola/vn/entry/b/u$1;->a:Lchat/ola/vn/message/k;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 0

    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Landroid/location/Address;",
            ">;)V"
        }
    .end annotation

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/u$1;->a:Lchat/ola/vn/message/k;

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/k;->b(Ljava/util/List;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/u$1;->b:Lchat/ola/vn/entry/b/u;

    invoke-static {p1}, Lchat/ola/vn/entry/b/u;->a(Lchat/ola/vn/entry/b/u;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
