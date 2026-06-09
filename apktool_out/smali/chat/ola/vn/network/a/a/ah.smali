.class public Lchat/ola/vn/network/a/a/ah;
.super Lchat/ola/vn/entity/m;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/entity/m<",
        "Lchat/ola/vn/entity/e;",
        ">;"
    }
.end annotation


# instance fields
.field private c:Ljava/lang/String;

.field private d:Z


# direct methods
.method public constructor <init>(Ljava/lang/String;ZJ)V
    .locals 0

    invoke-direct {p0, p3, p4}, Lchat/ola/vn/entity/m;-><init>(J)V

    iput-object p1, p0, Lchat/ola/vn/network/a/a/ah;->c:Ljava/lang/String;

    iput-boolean p2, p0, Lchat/ola/vn/network/a/a/ah;->d:Z

    return-void
.end method


# virtual methods
.method public synthetic a([B)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/ah;->b([B)Lchat/ola/vn/entity/e;

    move-result-object p1

    return-object p1
.end method

.method public a()Ljava/lang/String;
    .locals 6

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/network/a/a/ah;->c:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    const/4 v2, 0x0

    if-nez v1, :cond_1

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    iget-boolean v1, p0, Lchat/ola/vn/network/a/a/ah;->d:Z

    const/4 v3, 0x1

    if-eqz v1, :cond_0

    invoke-static {}, Lchat/ola/vn/h;->f()Ljava/lang/String;

    move-result-object v1

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "mall/like?id="

    :goto_0
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v5, p0, Lchat/ola/vn/network/a/a/ah;->c:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v5, "&owsn="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0, v2, v3}, Lchat/ola/vn/util/http/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Z)Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    invoke-static {}, Lchat/ola/vn/h;->f()Ljava/lang/String;

    move-result-object v1

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "mall/unlike?id="

    goto :goto_0

    :cond_1
    return-object v2
.end method

.method public a(Lchat/ola/vn/entity/e;)V
    .locals 0

    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Lchat/ola/vn/entity/e;

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/ah;->a(Lchat/ola/vn/entity/e;)V

    return-void
.end method

.method public b([B)Lchat/ola/vn/entity/e;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public b(Ljava/lang/String;)V
    .locals 0

    return-void
.end method
