.class public Lchat/ola/vn/pickercontacts/c;
.super Ljava/lang/Object;


# static fields
.field public static a:S = 0x0s

.field public static b:S = 0x1s

.field public static c:S = 0x2s


# instance fields
.field private d:J

.field private e:Ljava/lang/String;

.field private f:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private g:Ljava/lang/String;

.field private h:Z

.field private i:S


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-wide/16 v0, -0x1

    iput-wide v0, p0, Lchat/ola/vn/pickercontacts/c;->d:J

    sget-short v0, Lchat/ola/vn/pickercontacts/c;->b:S

    iput-short v0, p0, Lchat/ola/vn/pickercontacts/c;->i:S

    return-void
.end method


# virtual methods
.method public a()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/c;->e:Ljava/lang/String;

    return-object v0
.end method

.method public a(J)V
    .locals 0

    iput-wide p1, p0, Lchat/ola/vn/pickercontacts/c;->d:J

    return-void
.end method

.method public a(Lchat/ola/vn/pickercontacts/c;)V
    .locals 2

    invoke-virtual {p1}, Lchat/ola/vn/pickercontacts/c;->c()J

    move-result-wide v0

    iput-wide v0, p0, Lchat/ola/vn/pickercontacts/c;->d:J

    invoke-virtual {p1}, Lchat/ola/vn/pickercontacts/c;->a()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/pickercontacts/c;->e:Ljava/lang/String;

    new-instance v0, Ljava/util/ArrayList;

    invoke-virtual {p1}, Lchat/ola/vn/pickercontacts/c;->b()Ljava/util/List;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lchat/ola/vn/pickercontacts/c;->f:Ljava/util/List;

    invoke-virtual {p1}, Lchat/ola/vn/pickercontacts/c;->d()S

    move-result v0

    iput-short v0, p0, Lchat/ola/vn/pickercontacts/c;->i:S

    invoke-virtual {p1}, Lchat/ola/vn/pickercontacts/c;->g()Z

    move-result v0

    iput-boolean v0, p0, Lchat/ola/vn/pickercontacts/c;->h:Z

    invoke-virtual {p1}, Lchat/ola/vn/pickercontacts/c;->e()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/pickercontacts/c;->g:Ljava/lang/String;

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/pickercontacts/c;->e:Ljava/lang/String;

    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lchat/ola/vn/pickercontacts/c;->f:Ljava/util/List;

    return-void
.end method

.method public a(S)V
    .locals 0

    iput-short p1, p0, Lchat/ola/vn/pickercontacts/c;->i:S

    return-void
.end method

.method public b()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/c;->f:Ljava/util/List;

    return-object v0
.end method

.method public b(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/pickercontacts/c;->g:Ljava/lang/String;

    return-void
.end method

.method public c()J
    .locals 2

    iget-wide v0, p0, Lchat/ola/vn/pickercontacts/c;->d:J

    return-wide v0
.end method

.method public d()S
    .locals 1

    iget-short v0, p0, Lchat/ola/vn/pickercontacts/c;->i:S

    return v0
.end method

.method public e()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/c;->g:Ljava/lang/String;

    return-object v0
.end method

.method public f()Ljava/lang/String;
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/pickercontacts/c;->g:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/c;->g:Ljava/lang/String;

    return-object v0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/pickercontacts/c;->f:Ljava/util/List;

    const/4 v1, 0x0

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    const/4 v0, 0x0

    return-object v0
.end method

.method public g()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/pickercontacts/c;->h:Z

    return v0
.end method
