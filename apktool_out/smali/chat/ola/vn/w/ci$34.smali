.class Lchat/ola/vn/w/ci$34;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/w/ci;->a(SLjava/lang/String;Ljava/lang/String;S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:S

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Ljava/lang/String;

.field final synthetic d:S

.field final synthetic e:Lchat/ola/vn/w/ci;


# direct methods
.method constructor <init>(Lchat/ola/vn/w/ci;SLjava/lang/String;Ljava/lang/String;S)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/w/ci$34;->e:Lchat/ola/vn/w/ci;

    iput-short p2, p0, Lchat/ola/vn/w/ci$34;->a:S

    iput-object p3, p0, Lchat/ola/vn/w/ci$34;->b:Ljava/lang/String;

    iput-object p4, p0, Lchat/ola/vn/w/ci$34;->c:Ljava/lang/String;

    iput-short p5, p0, Lchat/ola/vn/w/ci$34;->d:S

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0xc2

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iget-short v1, p0, Lchat/ola/vn/w/ci$34;->a:S

    int-to-byte v1, v1

    iput-byte v1, v0, Lchat/ola/vn/w/bk;->as:B

    iget-object v1, p0, Lchat/ola/vn/w/ci$34;->b:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/w/ci$34;->c:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    iget-short v1, p0, Lchat/ola/vn/w/ci$34;->d:S

    iput-short v1, v0, Lchat/ola/vn/w/bk;->aj:S

    iget-object v1, p0, Lchat/ola/vn/w/ci$34;->e:Lchat/ola/vn/w/ci;

    const/4 v2, 0x1

    invoke-static {v1, v0, v2, v2}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/ci;Lchat/ola/vn/w/bk;ZZ)V

    return-void
.end method
