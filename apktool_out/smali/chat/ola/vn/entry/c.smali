.class public Lchat/ola/vn/entry/c;
.super Ljava/lang/Object;


# instance fields
.field public a:Lchat/ola/vn/entity/k;

.field private b:S

.field private c:Ljava/lang/CharSequence;

.field private d:Ljava/lang/CharSequence;

.field private e:Lchat/ola/vn/entity/t;

.field private f:I

.field private g:Ljava/lang/String;

.field private h:Ljava/lang/String;

.field private i:I


# direct methods
.method public constructor <init>(SLjava/lang/CharSequence;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/entry/c;->a:Lchat/ola/vn/entity/k;

    iput-short p1, p0, Lchat/ola/vn/entry/c;->b:S

    iput-object p2, p0, Lchat/ola/vn/entry/c;->c:Ljava/lang/CharSequence;

    return-void
.end method


# virtual methods
.method public a()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/entry/c;->f:I

    return v0
.end method

.method public a(Lchat/ola/vn/entity/t;)Lchat/ola/vn/entry/c;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/c;->e:Lchat/ola/vn/entity/t;

    return-object p0
.end method

.method public a(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/entry/c;->f:I

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/c;->g:Ljava/lang/String;

    return-void
.end method

.method public b()Lchat/ola/vn/entity/t;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entry/c;->e:Lchat/ola/vn/entity/t;

    return-object v0
.end method

.method public b(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/entry/c;->i:I

    return-void
.end method

.method public b(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/c;->h:Ljava/lang/String;

    return-void
.end method

.method public c()S
    .locals 1

    iget-short v0, p0, Lchat/ola/vn/entry/c;->b:S

    return v0
.end method

.method public d()Ljava/lang/CharSequence;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entry/c;->c:Ljava/lang/CharSequence;

    return-object v0
.end method

.method public e()Ljava/lang/CharSequence;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entry/c;->d:Ljava/lang/CharSequence;

    return-object v0
.end method

.method public f()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entry/c;->g:Ljava/lang/String;

    return-object v0
.end method

.method public g()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entry/c;->h:Ljava/lang/String;

    return-object v0
.end method
