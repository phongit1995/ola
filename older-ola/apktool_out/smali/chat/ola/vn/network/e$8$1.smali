.class Lchat/ola/vn/network/e$8$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/c;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e$8;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/network/e$8;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e$8;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$8$1;->a:Lchat/ola/vn/network/e$8;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(J)V
    .locals 0

    return-void
.end method

.method public a(JLchat/ola/vn/entity/f;)V
    .locals 0

    new-instance p1, Lchat/ola/vn/entity/g;

    invoke-direct {p1, p3}, Lchat/ola/vn/entity/g;-><init>(Lchat/ola/vn/entity/f;)V

    sget-object p2, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p2}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object p2

    if-nez p2, :cond_0

    sget-object p2, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p2, p1}, Lchat/ola/vn/r/a/e;->a(Lchat/ola/vn/entity/g;)V

    :cond_0
    return-void
.end method
