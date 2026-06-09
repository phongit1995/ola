.class Lchat/ola/vn/w/ci$36;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/w/ci;->c(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Ljava/lang/String;

.field final synthetic d:Lchat/ola/vn/w/ci;


# direct methods
.method constructor <init>(Lchat/ola/vn/w/ci;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/w/ci$36;->d:Lchat/ola/vn/w/ci;

    iput-object p2, p0, Lchat/ola/vn/w/ci$36;->a:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/w/ci$36;->b:Ljava/lang/String;

    iput-object p4, p0, Lchat/ola/vn/w/ci$36;->c:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    :try_start_0
    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x6d

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lchat/ola/vn/w/ci$36;->a:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "x"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lchat/ola/vn/w/ci$36;->b:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->d(Ljava/lang/String;)[B

    move-result-object v1

    array-length v2, v1

    const/4 v3, 0x1

    add-int/2addr v2, v3

    new-array v2, v2, [B

    const/4 v4, 0x4

    const/4 v5, 0x0

    aput-byte v4, v2, v5

    array-length v4, v1

    invoke-static {v1, v5, v2, v3, v4}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    iget-object v1, p0, Lchat/ola/vn/w/ci$36;->c:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    iput-object v2, v0, Lchat/ola/vn/w/bk;->ap:[B

    iget-object v1, p0, Lchat/ola/vn/w/ci$36;->d:Lchat/ola/vn/w/ci;

    invoke-static {v1, v0, v5, v3}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/ci;Lchat/ola/vn/w/bk;ZZ)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
