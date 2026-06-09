.class public Lchat/ola/vn/entry/e;
.super Ljava/lang/Object;


# instance fields
.field protected a:B

.field protected b:I

.field protected c:Ljava/lang/String;

.field protected d:Ljava/lang/String;

.field protected e:Ljava/lang/String;

.field protected f:I

.field protected g:I

.field protected h:Ljava/lang/String;

.field protected i:I

.field protected j:Ljava/lang/String;

.field protected k:Ljava/lang/String;

.field protected l:Z

.field private m:I

.field private n:I

.field private o:Ljava/lang/String;

.field private p:Z


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-byte v0, p0, Lchat/ola/vn/entry/e;->a:B

    const/4 v1, -0x1

    iput v1, p0, Lchat/ola/vn/entry/e;->n:I

    const/4 v1, 0x0

    iput-object v1, p0, Lchat/ola/vn/entry/e;->d:Ljava/lang/String;

    iput-object v1, p0, Lchat/ola/vn/entry/e;->e:Ljava/lang/String;

    iput v0, p0, Lchat/ola/vn/entry/e;->f:I

    const/4 v1, 0x1

    iput v1, p0, Lchat/ola/vn/entry/e;->g:I

    iput v0, p0, Lchat/ola/vn/entry/e;->i:I

    iput-boolean v0, p0, Lchat/ola/vn/entry/e;->p:Z

    iput-boolean v0, p0, Lchat/ola/vn/entry/e;->l:Z

    return-void
.end method

.method public constructor <init>(III)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-byte v0, p0, Lchat/ola/vn/entry/e;->a:B

    const/4 v1, -0x1

    iput v1, p0, Lchat/ola/vn/entry/e;->n:I

    const/4 v1, 0x0

    iput-object v1, p0, Lchat/ola/vn/entry/e;->d:Ljava/lang/String;

    iput-object v1, p0, Lchat/ola/vn/entry/e;->e:Ljava/lang/String;

    iput v0, p0, Lchat/ola/vn/entry/e;->f:I

    const/4 v1, 0x1

    iput v1, p0, Lchat/ola/vn/entry/e;->g:I

    iput v0, p0, Lchat/ola/vn/entry/e;->i:I

    iput-boolean v0, p0, Lchat/ola/vn/entry/e;->p:Z

    iput-boolean v0, p0, Lchat/ola/vn/entry/e;->l:Z

    iput p1, p0, Lchat/ola/vn/entry/e;->m:I

    iput p2, p0, Lchat/ola/vn/entry/e;->b:I

    iput p3, p0, Lchat/ola/vn/entry/e;->f:I

    return-void
.end method

.method public constructor <init>(ILjava/lang/String;Ljava/lang/String;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-byte v0, p0, Lchat/ola/vn/entry/e;->a:B

    const/4 v1, -0x1

    iput v1, p0, Lchat/ola/vn/entry/e;->n:I

    const/4 v1, 0x0

    iput-object v1, p0, Lchat/ola/vn/entry/e;->d:Ljava/lang/String;

    iput-object v1, p0, Lchat/ola/vn/entry/e;->e:Ljava/lang/String;

    iput v0, p0, Lchat/ola/vn/entry/e;->f:I

    const/4 v1, 0x1

    iput v1, p0, Lchat/ola/vn/entry/e;->g:I

    iput v0, p0, Lchat/ola/vn/entry/e;->i:I

    iput-boolean v0, p0, Lchat/ola/vn/entry/e;->p:Z

    iput-boolean v0, p0, Lchat/ola/vn/entry/e;->l:Z

    iput p1, p0, Lchat/ola/vn/entry/e;->m:I

    iput-object p2, p0, Lchat/ola/vn/entry/e;->d:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/entry/e;->c:Ljava/lang/String;

    return-void
.end method

.method public static a(III)Lchat/ola/vn/entry/e;
    .locals 1

    new-instance v0, Lchat/ola/vn/entry/e;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/entry/e;-><init>(III)V

    return-object v0
.end method

.method private final c(Z)V
    .locals 2

    if-eqz p1, :cond_1

    iget v0, p0, Lchat/ola/vn/entry/e;->g:I

    const/4 v1, 0x2

    if-eq v0, v1, :cond_0

    const/4 v0, 0x1

    iput v0, p0, Lchat/ola/vn/entry/e;->g:I

    :cond_0
    iget-boolean v0, p0, Lchat/ola/vn/entry/e;->p:Z

    if-nez v0, :cond_1

    iput-boolean p1, p0, Lchat/ola/vn/entry/e;->p:Z

    sget-object p1, Lchat/ola/vn/h;->v:Lchat/ola/vn/r/a/c;

    invoke-virtual {p1}, Lchat/ola/vn/r/a/c;->k()V

    :try_start_0
    sget-object p1, Lchat/ola/vn/h;->v:Lchat/ola/vn/r/a/c;

    invoke-virtual {p1}, Lchat/ola/vn/r/a/c;->g()V

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/activity/OlaBottomTabActivity;

    invoke-virtual {p1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->I()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void

    :cond_1
    iput-boolean p1, p0, Lchat/ola/vn/entry/e;->p:Z

    return-void
.end method


# virtual methods
.method public a(B)V
    .locals 0

    iput-byte p1, p0, Lchat/ola/vn/entry/e;->a:B

    return-void
.end method

.method public a(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/entry/e;->n:I

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/e;->d:Ljava/lang/String;

    return-void
.end method

.method public a(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/entry/e;->l:Z

    return-void
.end method

.method public a()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/entry/e;->l:Z

    return v0
.end method

.method public final a(Landroid/content/Context;)Z
    .locals 1

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/entry/e;->l:Z

    invoke-virtual {p0, p1}, Lchat/ola/vn/entry/e;->b(Landroid/content/Context;)Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-direct {p0, v0}, Lchat/ola/vn/entry/e;->c(Z)V

    :cond_0
    return p1
.end method

.method public b()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entry/e;->c:Ljava/lang/String;

    return-object v0
.end method

.method public b(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/entry/e;->g:I

    return-void
.end method

.method public b(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/e;->o:Ljava/lang/String;

    return-void
.end method

.method public final b(Z)V
    .locals 2

    if-eqz p1, :cond_0

    iget v0, p0, Lchat/ola/vn/entry/e;->g:I

    const/4 v1, 0x2

    if-eq v0, v1, :cond_0

    const/4 v0, 0x1

    iput v0, p0, Lchat/ola/vn/entry/e;->g:I

    :cond_0
    iput-boolean p1, p0, Lchat/ola/vn/entry/e;->p:Z

    return-void
.end method

.method public b(Landroid/content/Context;)Z
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method public c(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/entry/e;->i:I

    return-void
.end method

.method public c(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/e;->j:Ljava/lang/String;

    return-void
.end method

.method public c()Z
    .locals 3

    invoke-virtual {p0}, Lchat/ola/vn/entry/e;->m()Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return v1

    :cond_0
    iget v0, p0, Lchat/ola/vn/entry/e;->g:I

    const/4 v2, 0x2

    if-ne v0, v2, :cond_1

    const/4 v1, 0x1

    :cond_1
    return v1
.end method

.method public d()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/entry/e;->m:I

    return v0
.end method

.method public d(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/e;->e:Ljava/lang/String;

    return-void
.end method

.method public e()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/entry/e;->n:I

    return v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 3

    check-cast p1, Lchat/ola/vn/entry/e;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Lchat/ola/vn/entry/e;->d()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, "#"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Lchat/ola/vn/entry/e;->g()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1}, Lchat/ola/vn/entry/e;->d()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, "#"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Lchat/ola/vn/entry/e;->g()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p1

    return p1
.end method

.method public f()Ljava/lang/String;
    .locals 1

    iget v0, p0, Lchat/ola/vn/entry/e;->f:I

    if-eqz v0, :cond_0

    iget v0, p0, Lchat/ola/vn/entry/e;->f:I

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/e;->d:Ljava/lang/String;

    return-object v0
.end method

.method public g()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entry/e;->o:Ljava/lang/String;

    return-object v0
.end method

.method public h()Ljava/lang/String;
    .locals 2

    invoke-virtual {p0}, Lchat/ola/vn/entry/e;->m()Z

    move-result v0

    if-eqz v0, :cond_0

    iget v0, p0, Lchat/ola/vn/entry/e;->g:I

    const/4 v1, 0x2

    if-eq v0, v1, :cond_0

    const/4 v0, 0x0

    return-object v0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/e;->j:Ljava/lang/String;

    return-object v0
.end method

.method public i()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/entry/e;->b:I

    if-nez v0, :cond_0

    const v0, 0x7f080818

    return v0

    :cond_0
    iget v0, p0, Lchat/ola/vn/entry/e;->b:I

    return v0
.end method

.method public j()Ljava/lang/String;
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/entry/e;->h:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lchat/ola/vn/entry/e;->h:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ":"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lchat/ola/vn/entry/e;->i:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public k()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entry/e;->h:Ljava/lang/String;

    return-object v0
.end method

.method public l()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/entry/e;->i:I

    return v0
.end method

.method public m()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/entry/e;->p:Z

    return v0
.end method

.method public n()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entry/e;->e:Ljava/lang/String;

    return-object v0
.end method

.method public o()B
    .locals 1

    iget-byte v0, p0, Lchat/ola/vn/entry/e;->a:B

    return v0
.end method

.method public p()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entry/e;->k:Ljava/lang/String;

    return-object v0
.end method
