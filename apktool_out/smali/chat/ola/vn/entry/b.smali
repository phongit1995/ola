.class public Lchat/ola/vn/entry/b;
.super Ljava/lang/Object;


# instance fields
.field public a:Lchat/ola/vn/entity/f;

.field public b:Lchat/ola/vn/entity/g;

.field public c:Ljava/lang/CharSequence;

.field public d:Ljava/lang/CharSequence;

.field public e:[Ljava/lang/String;

.field public f:Ljava/lang/String;

.field public g:J

.field public h:Ljava/lang/String;

.field public i:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field public j:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field public k:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field public l:B

.field public m:Ljava/lang/String;

.field public n:Ljava/lang/String;

.field public o:Ljava/lang/String;

.field public p:Ljava/lang/String;

.field public q:Ljava/lang/String;

.field public r:I

.field private s:Z

.field private t:I

.field private u:B

.field private v:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iput-object v0, p0, Lchat/ola/vn/entry/b;->e:[Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entry/b;->f:Ljava/lang/String;

    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lchat/ola/vn/entry/b;->g:J

    const-string v1, ""

    iput-object v1, p0, Lchat/ola/vn/entry/b;->h:Ljava/lang/String;

    const/4 v1, 0x0

    iput-byte v1, p0, Lchat/ola/vn/entry/b;->l:B

    iput-object v0, p0, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entry/b;->n:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entry/b;->o:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entry/b;->p:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entry/b;->q:Ljava/lang/String;

    iput-boolean v1, p0, Lchat/ola/vn/entry/b;->s:Z

    iput v1, p0, Lchat/ola/vn/entry/b;->r:I

    iput-byte v1, p0, Lchat/ola/vn/entry/b;->u:B

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/entry/b;->i:Ljava/util/List;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/entry/b;->k:Ljava/util/List;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    new-instance v0, Lchat/ola/vn/entity/g;

    invoke-direct {v0}, Lchat/ola/vn/entity/g;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    return-void
.end method

.method public constructor <init>(Lchat/ola/vn/entity/g;)V
    .locals 8

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iput-object v0, p0, Lchat/ola/vn/entry/b;->e:[Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entry/b;->f:Ljava/lang/String;

    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lchat/ola/vn/entry/b;->g:J

    const-string v1, ""

    iput-object v1, p0, Lchat/ola/vn/entry/b;->h:Ljava/lang/String;

    const/4 v1, 0x0

    iput-byte v1, p0, Lchat/ola/vn/entry/b;->l:B

    iput-object v0, p0, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entry/b;->n:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entry/b;->o:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entry/b;->p:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entry/b;->q:Ljava/lang/String;

    iput-boolean v1, p0, Lchat/ola/vn/entry/b;->s:Z

    iput v1, p0, Lchat/ola/vn/entry/b;->r:I

    iput-byte v1, p0, Lchat/ola/vn/entry/b;->u:B

    iput-object p1, p0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->p()B

    move-result v2

    const/4 v3, 0x2

    const/4 v4, 0x1

    if-nez v2, :cond_0

    iput-byte v1, p0, Lchat/ola/vn/entry/b;->u:B

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->p()B

    move-result v2

    if-ne v2, v4, :cond_1

    iput-byte v4, p0, Lchat/ola/vn/entry/b;->u:B

    goto :goto_0

    :cond_1
    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->p()B

    move-result v2

    if-ne v2, v3, :cond_2

    iput-byte v3, p0, Lchat/ola/vn/entry/b;->u:B

    :cond_2
    :goto_0
    new-instance v2, Ljava/lang/StringBuffer;

    invoke-direct {v2}, Ljava/lang/StringBuffer;-><init>()V

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->b()Ljava/lang/String;

    move-result-object v5

    const-string v6, ""

    invoke-static {v5, v6, v2}, Lchat/ola/vn/util/i;->a(Ljava/lang/CharSequence;Ljava/lang/String;Ljava/lang/StringBuffer;)Ljava/util/List;

    move-result-object v5

    iput-object v5, p0, Lchat/ola/vn/entry/b;->v:Ljava/util/List;

    iget-object v5, p0, Lchat/ola/vn/entry/b;->v:Ljava/util/List;

    if-eqz v5, :cond_3

    iget-object v5, p0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v2}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v5, v2}, Lchat/ola/vn/entity/g;->b(Ljava/lang/String;)V

    :cond_3
    iget-object v2, p0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v2}, Lchat/ola/vn/entity/g;->b()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/util/i;->c(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v2

    iput-object v2, p0, Lchat/ola/vn/entry/b;->c:Ljava/lang/CharSequence;

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->c()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_5

    iget-object v2, p0, Lchat/ola/vn/entry/b;->v:Ljava/util/List;

    if-nez v2, :cond_4

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    iput-object v2, p0, Lchat/ola/vn/entry/b;->v:Ljava/util/List;

    :cond_4
    iget-object v2, p0, Lchat/ola/vn/entry/b;->v:Ljava/util/List;

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->c()Ljava/lang/String;

    move-result-object p1

    invoke-interface {v2, v1, p1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    :cond_5
    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/entry/b;->i:Ljava/util/List;

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/entry/b;->k:Ljava/util/List;

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/entry/b;->v:Ljava/util/List;

    if-eqz p1, :cond_c

    iget-object p1, p0, Lchat/ola/vn/entry/b;->v:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p1

    if-lez p1, :cond_c

    iget-object p1, p0, Lchat/ola/vn/entry/b;->v:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p1

    move-object v2, v0

    const/4 v0, 0x0

    :goto_1
    if-ge v0, p1, :cond_b

    iget-object v5, p0, Lchat/ola/vn/entry/b;->v:Ljava/util/List;

    invoke-interface {v5, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    invoke-virtual {v5, v4}, Ljava/lang/String;->charAt(I)C

    move-result v6

    const/16 v7, 0x50

    if-eq v6, v7, :cond_9

    const/16 v7, 0x53

    if-eq v6, v7, :cond_8

    const/16 v7, 0x56

    if-eq v6, v7, :cond_6

    goto :goto_3

    :cond_6
    if-nez v2, :cond_7

    move-object v2, v5

    :cond_7
    iget-object v6, p0, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    invoke-interface {v6, v5}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_a

    iget-object v6, p0, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    :goto_2
    invoke-interface {v6, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_3

    :cond_8
    iget-object v6, p0, Lchat/ola/vn/entry/b;->k:Ljava/util/List;

    invoke-interface {v6, v5}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_a

    iget-object v6, p0, Lchat/ola/vn/entry/b;->k:Ljava/util/List;

    goto :goto_2

    :cond_9
    iget-object v6, p0, Lchat/ola/vn/entry/b;->i:Ljava/util/List;

    invoke-interface {v6, v5}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_a

    iget-object v6, p0, Lchat/ola/vn/entry/b;->i:Ljava/util/List;

    goto :goto_2

    :cond_a
    :goto_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_b
    move-object v0, v2

    :cond_c
    iget-object p1, p0, Lchat/ola/vn/entry/b;->i:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p1

    if-nez p1, :cond_f

    iget-object p1, p0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->b()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_f

    iget-object v2, p0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v2}, Lchat/ola/vn/entity/g;->k()S

    move-result v2

    if-eq v2, v3, :cond_f

    iget-object v2, p0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v2}, Lchat/ola/vn/entity/g;->k()S

    move-result v2

    const/16 v5, 0xb

    if-eq v2, v5, :cond_f

    invoke-static {p1}, Lchat/ola/vn/util/i;->g(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_d

    iput-byte v4, p0, Lchat/ola/vn/entry/b;->l:B

    goto :goto_4

    :cond_d
    invoke-static {p1}, Lchat/ola/vn/util/i;->d(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_e

    iput-byte v1, p0, Lchat/ola/vn/entry/b;->l:B

    goto :goto_4

    :cond_e
    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_f

    iput-object v0, p0, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    iput-byte v3, p0, Lchat/ola/vn/entry/b;->l:B

    iget-object p1, p0, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->clear()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_f
    :goto_4
    iget-object p1, p0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->k()S

    move-result p1

    packed-switch p1, :pswitch_data_0

    :pswitch_0
    iget-object p1, p0, Lchat/ola/vn/entry/b;->i:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p1

    if-lez p1, :cond_10

    iput v4, p0, Lchat/ola/vn/entry/b;->t:I

    return-void

    :pswitch_1
    const/16 p1, 0x9

    goto :goto_5

    :pswitch_2
    const/16 p1, 0x8

    goto :goto_5

    :pswitch_3
    const/4 p1, 0x7

    goto :goto_5

    :pswitch_4
    const/4 p1, 0x6

    goto :goto_5

    :pswitch_5
    const/4 p1, 0x5

    goto :goto_5

    :pswitch_6
    const/4 p1, 0x4

    :goto_5
    iput p1, p0, Lchat/ola/vn/entry/b;->t:I

    return-void

    :cond_10
    iget-object p1, p0, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    if-eqz p1, :cond_11

    const/4 p1, 0x3

    goto :goto_5

    :cond_11
    iput v1, p0, Lchat/ola/vn/entry/b;->t:I

    return-void

    :pswitch_data_0
    .packed-switch 0x3
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_0
        :pswitch_0
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method public static a()Lchat/ola/vn/entry/b;
    .locals 2

    new-instance v0, Lchat/ola/vn/entry/b;

    invoke-direct {v0}, Lchat/ola/vn/entry/b;-><init>()V

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/b;->a(I)V

    return-object v0
.end method


# virtual methods
.method public a(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/entry/b;->t:I

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 5

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    const/16 v2, 0x21

    if-nez v0, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    iget-object v3, p0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v3}, Lchat/ola/vn/entity/g;->a()Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Landroid/text/SpannableStringBuilder;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v4, p0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v4}, Lchat/ola/vn/entity/g;->a()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, " \u00b7 "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p1}, Landroid/text/SpannableStringBuilder;-><init>(Ljava/lang/CharSequence;)V

    iput-object v0, p0, Lchat/ola/vn/entry/b;->d:Ljava/lang/CharSequence;

    iget-object p1, p0, Lchat/ola/vn/entry/b;->d:Ljava/lang/CharSequence;

    check-cast p1, Landroid/text/SpannableStringBuilder;

    new-instance v0, Landroid/text/style/ForegroundColorSpan;

    sget v3, Lchat/ola/vn/f;->y:I

    invoke-direct {v0, v3}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    iget-object v3, p0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v3}, Lchat/ola/vn/entity/g;->a()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    invoke-virtual {p1, v0, v1, v3, v2}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    iget-object p1, p0, Lchat/ola/vn/entry/b;->d:Ljava/lang/CharSequence;

    check-cast p1, Landroid/text/SpannableStringBuilder;

    new-instance v0, Landroid/text/style/ForegroundColorSpan;

    sget v1, Lchat/ola/vn/f;->z:I

    invoke-direct {v0, v1}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v1}, Lchat/ola/vn/entity/g;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    iget-object v3, p0, Lchat/ola/vn/entry/b;->d:Ljava/lang/CharSequence;

    invoke-interface {v3}, Ljava/lang/CharSequence;->length()I

    move-result v3

    invoke-virtual {p1, v0, v1, v3, v2}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->a()Ljava/lang/String;

    move-result-object p1

    new-instance v0, Landroid/text/SpannableStringBuilder;

    invoke-direct {v0, p1}, Landroid/text/SpannableStringBuilder;-><init>(Ljava/lang/CharSequence;)V

    iput-object v0, p0, Lchat/ola/vn/entry/b;->d:Ljava/lang/CharSequence;

    iget-object v0, p0, Lchat/ola/vn/entry/b;->d:Ljava/lang/CharSequence;

    check-cast v0, Landroid/text/SpannableStringBuilder;

    new-instance v3, Landroid/text/style/ForegroundColorSpan;

    sget v4, Lchat/ola/vn/f;->y:I

    invoke-direct {v3, v4}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p1

    invoke-virtual {v0, v3, v1, p1, v2}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    :goto_0
    invoke-static {}, Lchat/ola/vn/util/g;->a()Lchat/ola/vn/util/g;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/entry/b;->d:Ljava/lang/CharSequence;

    invoke-virtual {p1, v0}, Lchat/ola/vn/util/g;->a(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/entry/b;->d:Ljava/lang/CharSequence;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/entry/b;->s:Z

    return-void
.end method

.method public b()Ljava/lang/CharSequence;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entry/b;->d:Ljava/lang/CharSequence;

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->w()Ljava/lang/String;

    move-result-object v0

    :goto_0
    invoke-virtual {p0, v0}, Lchat/ola/vn/entry/b;->a(Ljava/lang/String;)V

    goto :goto_1

    :cond_0
    const/4 v0, 0x0

    goto :goto_0

    :cond_1
    :goto_1
    iget-object v0, p0, Lchat/ola/vn/entry/b;->d:Ljava/lang/CharSequence;

    return-object v0
.end method

.method public c()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->a()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public d()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/entry/b;->t:I

    return v0
.end method

.method public e()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/entry/b;->s:Z

    return v0
.end method

.method public f()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/entry/b;->i:Ljava/util/List;

    return-object v0
.end method

.method public g()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/entry/b;->v:Ljava/util/List;

    return-object v0
.end method

.method public h()B
    .locals 1

    iget-byte v0, p0, Lchat/ola/vn/entry/b;->u:B

    return v0
.end method
