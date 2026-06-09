.class public Lchat/ola/vn/entity/f;
.super Ljava/lang/Object;


# instance fields
.field public a:Z

.field public b:Lchat/ola/vn/entity/d;

.field public c:J

.field public d:Ljava/lang/CharSequence;

.field public e:Ljava/lang/String;

.field public f:Ljava/lang/String;

.field public g:J

.field public h:J

.field public i:[Ljava/lang/String;

.field public j:Lchat/ola/vn/entity/w;

.field public k:Ljava/lang/String;

.field public l:Ljava/lang/String;

.field public m:Ljava/lang/String;

.field public n:Ljava/lang/String;

.field public o:Ljava/lang/String;

.field public p:Ljava/lang/String;

.field public q:Ljava/lang/CharSequence;

.field public r:I

.field public s:I

.field public t:I

.field protected u:S


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/entity/f;->a:Z

    const/4 v1, 0x0

    iput-object v1, p0, Lchat/ola/vn/entity/f;->d:Ljava/lang/CharSequence;

    iput-object v1, p0, Lchat/ola/vn/entity/f;->j:Lchat/ola/vn/entity/w;

    iput-short v0, p0, Lchat/ola/vn/entity/f;->u:S

    return-void
.end method


# virtual methods
.method public a(S)V
    .locals 0

    iput-short p1, p0, Lchat/ola/vn/entity/f;->u:S

    return-void
.end method

.method public a()Z
    .locals 2

    iget-short v0, p0, Lchat/ola/vn/entity/f;->u:S

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    return v1

    :cond_0
    const/4 v1, 0x0

    return v1
.end method

.method public b()Z
    .locals 2

    iget-short v0, p0, Lchat/ola/vn/entity/f;->u:S

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public c()S
    .locals 1

    iget-short v0, p0, Lchat/ola/vn/entity/f;->u:S

    return v0
.end method
