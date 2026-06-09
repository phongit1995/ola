.class Lchat/ola/vn/w/ci$6;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/w/ci;->a(JJS)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:J

.field final synthetic b:J

.field final synthetic c:S

.field final synthetic d:Lchat/ola/vn/w/ci;


# direct methods
.method constructor <init>(Lchat/ola/vn/w/ci;JJS)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/w/ci$6;->d:Lchat/ola/vn/w/ci;

    iput-wide p2, p0, Lchat/ola/vn/w/ci$6;->a:J

    iput-wide p4, p0, Lchat/ola/vn/w/ci$6;->b:J

    iput-short p6, p0, Lchat/ola/vn/w/ci$6;->c:S

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x5c

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iget-wide v1, p0, Lchat/ola/vn/w/ci$6;->a:J

    iput-wide v1, v0, Lchat/ola/vn/w/bk;->S:J

    iget-wide v1, p0, Lchat/ola/vn/w/ci$6;->b:J

    iput-wide v1, v0, Lchat/ola/vn/w/bk;->V:J

    iget-short v1, p0, Lchat/ola/vn/w/ci$6;->c:S

    iput-short v1, v0, Lchat/ola/vn/w/bk;->aj:S

    iget-object v1, p0, Lchat/ola/vn/w/ci$6;->d:Lchat/ola/vn/w/ci;

    iget-short v2, p0, Lchat/ola/vn/w/ci$6;->c:S

    iput-short v2, v1, Lchat/ola/vn/w/ci;->p:S

    iget-object v1, p0, Lchat/ola/vn/w/ci$6;->d:Lchat/ola/vn/w/ci;

    const/4 v2, 0x0

    const/4 v3, 0x1

    invoke-static {v1, v0, v2, v3}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/ci;Lchat/ola/vn/w/bk;ZZ)V

    return-void
.end method
