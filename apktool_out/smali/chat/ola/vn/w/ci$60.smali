.class Lchat/ola/vn/w/ci$60;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/w/ci;->a(Ljava/lang/String;SZ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:S

.field final synthetic c:Z

.field final synthetic d:Lchat/ola/vn/w/ci;


# direct methods
.method constructor <init>(Lchat/ola/vn/w/ci;Ljava/lang/String;SZ)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/w/ci$60;->d:Lchat/ola/vn/w/ci;

    iput-object p2, p0, Lchat/ola/vn/w/ci$60;->a:Ljava/lang/String;

    iput-short p3, p0, Lchat/ola/vn/w/ci$60;->b:S

    iput-boolean p4, p0, Lchat/ola/vn/w/ci$60;->c:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0xd1

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    const/4 v1, 0x2

    iput-byte v1, v0, Lchat/ola/vn/w/bk;->au:B

    iget-object v1, p0, Lchat/ola/vn/w/ci$60;->a:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/w/bk;->N:Ljava/lang/String;

    iget-short v1, p0, Lchat/ola/vn/w/ci$60;->b:S

    int-to-byte v1, v1

    iput-byte v1, v0, Lchat/ola/vn/w/bk;->av:B

    iget-boolean v1, p0, Lchat/ola/vn/w/ci$60;->c:Z

    const/4 v2, 0x1

    if-eqz v1, :cond_0

    iput-byte v2, v0, Lchat/ola/vn/w/bk;->as:B

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/w/ci$60;->d:Lchat/ola/vn/w/ci;

    invoke-static {v1, v0, v2, v2}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/ci;Lchat/ola/vn/w/bk;ZZ)V

    return-void
.end method
