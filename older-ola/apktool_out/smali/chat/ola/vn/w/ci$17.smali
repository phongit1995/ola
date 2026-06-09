.class Lchat/ola/vn/w/ci$17;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/w/ci;->a(BLjava/lang/String;JS)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:B

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:J

.field final synthetic d:S

.field final synthetic e:Lchat/ola/vn/w/ci;


# direct methods
.method constructor <init>(Lchat/ola/vn/w/ci;BLjava/lang/String;JS)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/w/ci$17;->e:Lchat/ola/vn/w/ci;

    iput-byte p2, p0, Lchat/ola/vn/w/ci$17;->a:B

    iput-object p3, p0, Lchat/ola/vn/w/ci$17;->b:Ljava/lang/String;

    iput-wide p4, p0, Lchat/ola/vn/w/ci$17;->c:J

    iput-short p6, p0, Lchat/ola/vn/w/ci$17;->d:S

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x5b

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iget-byte v1, p0, Lchat/ola/vn/w/ci$17;->a:B

    iput-byte v1, v0, Lchat/ola/vn/w/bk;->as:B

    iget-object v1, p0, Lchat/ola/vn/w/ci$17;->b:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    iget-wide v1, p0, Lchat/ola/vn/w/ci$17;->c:J

    iput-wide v1, v0, Lchat/ola/vn/w/bk;->S:J

    iget-short v1, p0, Lchat/ola/vn/w/ci$17;->d:S

    iput-short v1, v0, Lchat/ola/vn/w/bk;->ac:S

    iget-object v1, p0, Lchat/ola/vn/w/ci$17;->e:Lchat/ola/vn/w/ci;

    invoke-static {v1, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/ci;Lchat/ola/vn/w/bk;)V

    return-void
.end method
