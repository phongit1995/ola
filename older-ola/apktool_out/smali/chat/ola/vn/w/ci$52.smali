.class Lchat/ola/vn/w/ci$52;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/w/ci;->a(BLjava/lang/String;SLjava/lang/String;S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:B

.field final synthetic b:S

.field final synthetic c:Ljava/lang/String;

.field final synthetic d:Ljava/lang/String;

.field final synthetic e:S

.field final synthetic f:Lchat/ola/vn/w/ci;


# direct methods
.method constructor <init>(Lchat/ola/vn/w/ci;BSLjava/lang/String;Ljava/lang/String;S)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/w/ci$52;->f:Lchat/ola/vn/w/ci;

    iput-byte p2, p0, Lchat/ola/vn/w/ci$52;->a:B

    iput-short p3, p0, Lchat/ola/vn/w/ci$52;->b:S

    iput-object p4, p0, Lchat/ola/vn/w/ci$52;->c:Ljava/lang/String;

    iput-object p5, p0, Lchat/ola/vn/w/ci$52;->d:Ljava/lang/String;

    iput-short p6, p0, Lchat/ola/vn/w/ci$52;->e:S

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x39

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iget-byte v1, p0, Lchat/ola/vn/w/ci$52;->a:B

    iput-byte v1, v0, Lchat/ola/vn/w/bk;->as:B

    iget-short v1, p0, Lchat/ola/vn/w/ci$52;->b:S

    iput-short v1, v0, Lchat/ola/vn/w/bk;->al:S

    iget-object v1, p0, Lchat/ola/vn/w/ci$52;->c:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/w/ci$52;->d:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/w/bk;->C:Ljava/lang/String;

    iget-short v1, p0, Lchat/ola/vn/w/ci$52;->e:S

    iput-short v1, v0, Lchat/ola/vn/w/bk;->aj:S

    iget-object v1, p0, Lchat/ola/vn/w/ci$52;->f:Lchat/ola/vn/w/ci;

    invoke-static {v1, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/ci;Lchat/ola/vn/w/bk;)V

    return-void
.end method
