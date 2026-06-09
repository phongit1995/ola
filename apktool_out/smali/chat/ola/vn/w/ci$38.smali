.class Lchat/ola/vn/w/ci$38;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/w/ci;->a(Ljava/lang/String;[BS)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:[B

.field final synthetic b:S

.field final synthetic c:Ljava/lang/String;

.field final synthetic d:Lchat/ola/vn/w/ci;


# direct methods
.method constructor <init>(Lchat/ola/vn/w/ci;[BSLjava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/w/ci$38;->d:Lchat/ola/vn/w/ci;

    iput-object p2, p0, Lchat/ola/vn/w/ci$38;->a:[B

    iput-short p3, p0, Lchat/ola/vn/w/ci$38;->b:S

    iput-object p4, p0, Lchat/ola/vn/w/ci$38;->c:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 8

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x6d

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iget-object v1, p0, Lchat/ola/vn/w/ci$38;->a:[B

    array-length v1, v1

    const/4 v2, 0x4

    add-int/2addr v1, v2

    new-array v1, v1, [B

    const/4 v3, 0x0

    const/4 v4, 0x7

    aput-byte v4, v1, v3

    const/4 v4, 0x1

    aput-byte v3, v1, v4

    iget-short v5, p0, Lchat/ola/vn/w/ci$38;->b:S

    invoke-static {v5}, Lchat/ola/vn/util/e;->a(S)[B

    move-result-object v5

    aget-byte v6, v5, v3

    const/4 v7, 0x2

    aput-byte v6, v1, v7

    aget-byte v5, v5, v4

    const/4 v6, 0x3

    aput-byte v5, v1, v6

    iget-object v5, p0, Lchat/ola/vn/w/ci$38;->a:[B

    iget-object v6, p0, Lchat/ola/vn/w/ci$38;->a:[B

    array-length v6, v6

    invoke-static {v5, v3, v1, v2, v6}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    iget-object v2, p0, Lchat/ola/vn/w/ci$38;->c:Ljava/lang/String;

    iput-object v2, v0, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/w/bk;->ap:[B

    iget-object v1, p0, Lchat/ola/vn/w/ci$38;->d:Lchat/ola/vn/w/ci;

    invoke-static {v1, v0, v3, v4}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/ci;Lchat/ola/vn/w/bk;ZZ)V

    return-void
.end method
