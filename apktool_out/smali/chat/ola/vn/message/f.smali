.class public Lchat/ola/vn/message/f;
.super Ljava/lang/Object;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "DefaultLocale"
    }
.end annotation


# instance fields
.field A:Lchat/ola/vn/message/g;

.field public B:Z

.field public C:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field public D:I

.field public E:I

.field public F:Ljava/lang/Boolean;

.field public G:Z

.field public H:J

.field protected I:Z

.field public J:Ljava/lang/Long;

.field public K:Ljava/lang/Long;

.field public L:J

.field public M:J

.field public N:J

.field public O:Ljava/lang/String;

.field protected P:Ljava/lang/String;

.field public Q:Z

.field public R:Ljava/lang/String;

.field public S:Lchat/ola/vn/message/d;

.field public T:Lchat/ola/vn/message/d;

.field U:Ljava/lang/String;

.field public V:B

.field protected W:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/message/d;",
            ">;"
        }
    .end annotation
.end field

.field X:I

.field Y:I

.field private Z:Ljava/lang/Boolean;

.field private a:J

.field private aa:Ljava/lang/Boolean;

.field private ab:Ljava/lang/Long;

.field private ac:Z

.field private ad:Ljava/lang/CharSequence;

.field private ae:Ljava/lang/CharSequence;

.field private af:B

.field private ag:Z

.field private ah:Lchat/ola/vn/game/caro/b;

.field private ai:Z

.field private aj:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lchat/ola/vn/message/d;",
            ">;"
        }
    .end annotation
.end field

.field private b:I

.field protected c:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;"
        }
    .end annotation
.end field

.field protected d:Ljava/lang/String;

.field protected e:Ljava/lang/String;

.field protected f:Ljava/lang/String;

.field protected g:Ljava/lang/String;

.field protected h:Ljava/lang/String;

.field protected i:Ljava/lang/String;

.field protected j:Ljava/lang/String;

.field protected k:Ljava/lang/String;

.field protected l:Ljava/lang/String;

.field protected m:Ljava/lang/String;

.field public n:Ljava/lang/String;

.field protected o:J

.field public p:J

.field public q:Ljava/lang/Long;

.field public r:J

.field public s:J

.field public t:J

.field protected u:S

.field protected v:S

.field protected w:S

.field protected x:S

.field protected y:B

.field protected z:B


# direct methods
.method public constructor <init>(Ljava/lang/String;S)V
    .locals 8

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/message/f;->n:Ljava/lang/String;

    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lchat/ola/vn/message/f;->o:J

    iput-wide v1, p0, Lchat/ola/vn/message/f;->p:J

    iput-object v0, p0, Lchat/ola/vn/message/f;->q:Ljava/lang/Long;

    iput-wide v1, p0, Lchat/ola/vn/message/f;->r:J

    iput-wide v1, p0, Lchat/ola/vn/message/f;->s:J

    iput-wide v1, p0, Lchat/ola/vn/message/f;->t:J

    const/4 v3, 0x0

    iput v3, p0, Lchat/ola/vn/message/f;->b:I

    iput-short v3, p0, Lchat/ola/vn/message/f;->u:S

    const/4 v4, -0x1

    iput-short v4, p0, Lchat/ola/vn/message/f;->v:S

    iput-short v3, p0, Lchat/ola/vn/message/f;->x:S

    iput-byte v4, p0, Lchat/ola/vn/message/f;->y:B

    iput-byte v3, p0, Lchat/ola/vn/message/f;->z:B

    iput-object v0, p0, Lchat/ola/vn/message/f;->Z:Ljava/lang/Boolean;

    iput-object v0, p0, Lchat/ola/vn/message/f;->aa:Ljava/lang/Boolean;

    iput-object v0, p0, Lchat/ola/vn/message/f;->ab:Ljava/lang/Long;

    iput-boolean v3, p0, Lchat/ola/vn/message/f;->ac:Z

    const/4 v5, 0x1

    iput-boolean v5, p0, Lchat/ola/vn/message/f;->B:Z

    iput-object v0, p0, Lchat/ola/vn/message/f;->ad:Ljava/lang/CharSequence;

    iput-object v0, p0, Lchat/ola/vn/message/f;->ae:Ljava/lang/CharSequence;

    iput-object v0, p0, Lchat/ola/vn/message/f;->C:Ljava/util/List;

    iput v4, p0, Lchat/ola/vn/message/f;->D:I

    iput v3, p0, Lchat/ola/vn/message/f;->E:I

    iput-object v0, p0, Lchat/ola/vn/message/f;->F:Ljava/lang/Boolean;

    const/4 v6, 0x5

    iput-byte v6, p0, Lchat/ola/vn/message/f;->af:B

    iput-boolean v3, p0, Lchat/ola/vn/message/f;->G:Z

    iput-boolean v3, p0, Lchat/ola/vn/message/f;->ag:Z

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    iput-wide v6, p0, Lchat/ola/vn/message/f;->H:J

    iput-object v0, p0, Lchat/ola/vn/message/f;->ah:Lchat/ola/vn/game/caro/b;

    iput-boolean v3, p0, Lchat/ola/vn/message/f;->ai:Z

    iput-boolean v3, p0, Lchat/ola/vn/message/f;->I:Z

    iput-object v0, p0, Lchat/ola/vn/message/f;->J:Ljava/lang/Long;

    iput-object v0, p0, Lchat/ola/vn/message/f;->K:Ljava/lang/Long;

    iput-wide v1, p0, Lchat/ola/vn/message/f;->L:J

    iput-wide v1, p0, Lchat/ola/vn/message/f;->M:J

    iput-wide v1, p0, Lchat/ola/vn/message/f;->N:J

    iput-object v0, p0, Lchat/ola/vn/message/f;->aj:Ljava/util/Map;

    iput-object v0, p0, Lchat/ola/vn/message/f;->O:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/message/f;->P:Ljava/lang/String;

    iput-boolean v5, p0, Lchat/ola/vn/message/f;->Q:Z

    iput-object v0, p0, Lchat/ola/vn/message/f;->R:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/message/f;->S:Lchat/ola/vn/message/d;

    iput-object v0, p0, Lchat/ola/vn/message/f;->T:Lchat/ola/vn/message/d;

    iput-object v0, p0, Lchat/ola/vn/message/f;->U:Ljava/lang/String;

    iput-byte v3, p0, Lchat/ola/vn/message/f;->V:B

    iput v4, p0, Lchat/ola/vn/message/f;->X:I

    iput v4, p0, Lchat/ola/vn/message/f;->Y:I

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;S)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/message/f;->d:Ljava/lang/String;

    iput-short p2, p0, Lchat/ola/vn/message/f;->x:S

    iget-object p1, p0, Lchat/ola/vn/message/f;->d:Ljava/lang/String;

    invoke-static {p1, p2}, Lchat/ola/vn/message/f;->b(Ljava/lang/String;S)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/message/f;->U:Ljava/lang/String;

    iput-wide v1, p0, Lchat/ola/vn/message/f;->M:J

    iget-short p1, p0, Lchat/ola/vn/message/f;->x:S

    if-ne p1, v5, :cond_0

    iput-boolean v3, p0, Lchat/ola/vn/message/f;->B:Z

    :cond_0
    return-void
.end method

.method private Y()V
    .locals 2

    iget v0, p0, Lchat/ola/vn/message/f;->b:I

    if-nez v0, :cond_0

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->U()I

    move-result v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/c/b;->a(Landroid/content/Context;I)V

    :cond_0
    return-void
.end method

.method private Z()Ljava/lang/CharSequence;
    .locals 1

    const-string v0, ""

    invoke-direct {p0, v0}, Lchat/ola/vn/message/f;->p(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v0

    return-object v0
.end method

.method private a(Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;)V
    .locals 8

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/message/f;->H()Z

    move-result v0

    if-eqz v0, :cond_2

    iget-boolean v0, p0, Lchat/ola/vn/message/f;->G:Z

    if-eqz v0, :cond_2

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->d()B

    move-result v0

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    return-void

    :cond_0
    if-eqz p2, :cond_1

    invoke-virtual {p2}, Lchat/ola/vn/message/d;->d()B

    move-result v0

    if-ne v0, v1, :cond_1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {p2}, Lchat/ola/vn/message/d;->m()J

    move-result-wide v4

    const/4 p2, 0x0

    sub-long v6, v2, v4

    const-wide/32 v2, 0x2932e00

    cmp-long p2, v6, v2

    if-gez p2, :cond_1

    return-void

    :cond_1
    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p2

    invoke-virtual {p0, p2}, Lchat/ola/vn/message/f;->a(Ljava/lang/Boolean;)V

    sget-object p2, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    if-eqz p2, :cond_2

    sget-object p2, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-static {}, Lchat/ola/vn/OlaApplication;->e()Z

    move-result v0

    invoke-virtual {p2, p0, p1, v0}, Lchat/ola/vn/balloon/OlaBalloonService;->a(Lchat/ola/vn/message/f;Lchat/ola/vn/message/d;Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method

.method private aa()Ljava/lang/CharSequence;
    .locals 6

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->e()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v0, 0x0

    return-object v0

    :cond_0
    new-instance v1, Landroid/text/SpannableStringBuilder;

    invoke-direct {v1, v0}, Landroid/text/SpannableStringBuilder;-><init>(Ljava/lang/CharSequence;)V

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v0

    if-lez v0, :cond_1

    move-object v0, v1

    check-cast v0, Landroid/text/Spannable;

    new-instance v2, Landroid/text/style/ForegroundColorSpan;

    sget v3, Lchat/ola/vn/f;->D:I

    invoke-direct {v2, v3}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    const/4 v3, 0x0

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v4

    const/16 v5, 0x12

    invoke-interface {v0, v2, v3, v4, v5}, Landroid/text/Spannable;->setSpan(Ljava/lang/Object;III)V

    :cond_1
    return-object v1
.end method

.method public static b(Ljava/lang/String;S)Ljava/lang/String;
    .locals 2

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 p0, 0x0

    return-object p0

    :cond_0
    const/4 v0, 0x1

    if-ne p1, v0, :cond_1

    const/4 p1, 0x0

    goto :goto_1

    :cond_1
    const/4 v0, 0x2

    if-ne p1, v0, :cond_2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    :goto_0
    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p0, "#"

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_2
    :goto_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {p0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object p0

    goto :goto_0
.end method

.method public static c(Ljava/lang/String;S)I
    .locals 0

    :try_start_0
    invoke-static {p0, p1}, Lchat/ola/vn/message/f;->b(Ljava/lang/String;S)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/String;->hashCode()I

    move-result p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return p0

    :catch_0
    const/16 p0, 0x64

    return p0
.end method

.method private d(J)Z
    .locals 5

    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Ljava/util/Calendar;->setTimeInMillis(J)V

    const/4 p1, 0x5

    invoke-virtual {v0, p1}, Ljava/util/Calendar;->get(I)I

    move-result p2

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Ljava/util/Calendar;->get(I)I

    move-result v2

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    invoke-virtual {v0, v3, v4}, Ljava/util/Calendar;->setTimeInMillis(J)V

    invoke-virtual {v0, p1}, Ljava/util/Calendar;->get(I)I

    move-result p1

    invoke-virtual {v0, v1}, Ljava/util/Calendar;->get(I)I

    move-result v0

    const/4 v1, 0x0

    if-ne v2, v0, :cond_0

    if-gt p1, p2, :cond_1

    return v1

    :cond_0
    if-ge v2, v0, :cond_2

    if-nez v2, :cond_1

    const/16 p1, 0xb

    if-ne v0, p1, :cond_1

    return v1

    :cond_1
    const/4 p1, 0x1

    return p1

    :cond_2
    return v1
.end method

.method private p(Ljava/lang/String;)Ljava/lang/CharSequence;
    .locals 6

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->e()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string p1, ""

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->e()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " \u00b7 "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->e()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_1
    move-object v0, p1

    :goto_0
    invoke-static {v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    const/4 p1, 0x0

    return-object p1

    :cond_2
    new-instance v1, Landroid/text/SpannableStringBuilder;

    invoke-direct {v1, v0}, Landroid/text/SpannableStringBuilder;-><init>(Ljava/lang/CharSequence;)V

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v0

    if-lez v0, :cond_4

    invoke-static {p1}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    const/4 v2, 0x0

    const/16 v3, 0x12

    if-nez v0, :cond_3

    move-object v0, v1

    check-cast v0, Landroid/text/Spannable;

    new-instance v4, Landroid/text/style/ForegroundColorSpan;

    sget v5, Lchat/ola/vn/f;->y:I

    invoke-direct {v4, v5}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v5

    invoke-interface {v0, v4, v2, v5, v3}, Landroid/text/Spannable;->setSpan(Ljava/lang/Object;III)V

    new-instance v2, Landroid/text/style/ForegroundColorSpan;

    sget v4, Lchat/ola/vn/f;->z:I

    invoke-direct {v2, v4}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p1

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v4

    invoke-interface {v0, v2, p1, v4, v3}, Landroid/text/Spannable;->setSpan(Ljava/lang/Object;III)V

    return-object v1

    :cond_3
    move-object p1, v1

    check-cast p1, Landroid/text/Spannable;

    new-instance v0, Landroid/text/style/ForegroundColorSpan;

    sget v4, Lchat/ola/vn/f;->z:I

    invoke-direct {v0, v4}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v4

    invoke-interface {p1, v0, v2, v4, v3}, Landroid/text/Spannable;->setSpan(Ljava/lang/Object;III)V

    :cond_4
    return-object v1
.end method


# virtual methods
.method public A()V
    .locals 1

    const/4 v0, 0x5

    iput-byte v0, p0, Lchat/ola/vn/message/f;->af:B

    return-void
.end method

.method public B()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/message/f;->c:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/message/f;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/message/f;->c:Ljava/util/List;

    :cond_0
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/message/f;->a:J

    return-void
.end method

.method public C()V
    .locals 2

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->B()V

    iget-object v0, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    iput-object v1, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/message/f;->aj:Ljava/util/Map;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/message/f;->aj:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->clear()V

    iput-object v1, p0, Lchat/ola/vn/message/f;->aj:Ljava/util/Map;

    :cond_1
    iput-object v1, p0, Lchat/ola/vn/message/f;->S:Lchat/ola/vn/message/d;

    iput-object v1, p0, Lchat/ola/vn/message/f;->F:Ljava/lang/Boolean;

    iput-object v1, p0, Lchat/ola/vn/message/f;->T:Lchat/ola/vn/message/d;

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/message/f;->b:I

    invoke-direct {p0}, Lchat/ola/vn/message/f;->Y()V

    iput-byte v0, p0, Lchat/ola/vn/message/f;->V:B

    iput-object v1, p0, Lchat/ola/vn/message/f;->n:Ljava/lang/String;

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/message/f;->s:J

    iget-object v0, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    iget-object v1, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    invoke-virtual {v0, p0, v1}, Lchat/ola/vn/message/g;->a(Lchat/ola/vn/message/f;Ljava/util/List;)V

    :cond_2
    return-void
.end method

.method public D()V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    iput-object v1, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/message/f;->aj:Ljava/util/Map;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/message/f;->aj:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->clear()V

    iput-object v1, p0, Lchat/ola/vn/message/f;->aj:Ljava/util/Map;

    :cond_1
    iput-object v1, p0, Lchat/ola/vn/message/f;->S:Lchat/ola/vn/message/d;

    iput-object v1, p0, Lchat/ola/vn/message/f;->F:Ljava/lang/Boolean;

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/message/f;->b:I

    invoke-direct {p0}, Lchat/ola/vn/message/f;->Y()V

    iput-object v1, p0, Lchat/ola/vn/message/f;->T:Lchat/ola/vn/message/d;

    iput-byte v0, p0, Lchat/ola/vn/message/f;->V:B

    iput-object v1, p0, Lchat/ola/vn/message/f;->n:Ljava/lang/String;

    const-wide/16 v2, 0x0

    iput-wide v2, p0, Lchat/ola/vn/message/f;->s:J

    iput-object v1, p0, Lchat/ola/vn/message/f;->P:Ljava/lang/String;

    iput-object v1, p0, Lchat/ola/vn/message/f;->O:Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    iget-object v1, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    invoke-virtual {v0, p0, v1}, Lchat/ola/vn/message/g;->a(Lchat/ola/vn/message/f;Ljava/util/List;)V

    :cond_2
    return-void
.end method

.method public E()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    invoke-virtual {v0}, Lchat/ola/vn/message/g;->u()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public F()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;"
        }
    .end annotation

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lchat/ola/vn/message/f;->a(Z)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public G()Ljava/util/List;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    const/4 v1, 0x0

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :catch_0
    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/message/d;

    invoke-virtual {v2}, Lchat/ola/vn/message/d;->x()Z

    move-result v3

    if-eqz v3, :cond_0

    :try_start_0
    check-cast v2, Lchat/ola/vn/message/p;

    invoke-virtual {v2}, Lchat/ola/vn/message/p;->a()Ljava/util/List;

    move-result-object v2

    if-eqz v2, :cond_0

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v3

    if-lez v3, :cond_0

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_1
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/entity/ab;

    iget-byte v4, v3, Lchat/ola/vn/entity/ab;->b:B

    if-nez v4, :cond_1

    iget-object v4, v3, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    invoke-static {v4}, Lchat/ola/vn/entity/i;->i(Ljava/lang/String;)C

    move-result v4

    const/4 v5, 0x1

    if-ne v4, v5, :cond_1

    if-nez v1, :cond_2

    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    move-object v1, v4

    :cond_2
    iget-object v3, v3, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    invoke-interface {v1, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :cond_3
    return-object v1
.end method

.method public H()Z
    .locals 2

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->W()Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/message/f;->Z:Ljava/lang/Boolean;

    if-nez v0, :cond_1

    sget-byte v0, Lchat/ola/vn/c/x;->k:B

    if-nez v0, :cond_0

    const/4 v1, 0x1

    :cond_0
    return v1

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/message/f;->Z:Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    return v0

    :cond_2
    return v1
.end method

.method public I()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/message/f;->ac:Z

    return v0
.end method

.method public J()V
    .locals 8

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/message/f;->g:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iput-object v1, p0, Lchat/ola/vn/message/f;->C:Ljava/util/List;

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/message/f;->g:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/i;->b(Ljava/lang/CharSequence;)Ljava/util/ArrayList;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/f;->C:Ljava/util/List;

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/message/f;->C:Ljava/util/List;

    const/4 v2, 0x0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/message/f;->C:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/message/f;->C:Ljava/util/List;

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/message/f;->R:Ljava/lang/String;

    goto :goto_1

    :cond_1
    iput-object v1, p0, Lchat/ola/vn/message/f;->R:Ljava/lang/String;

    :goto_1
    iget-short v0, p0, Lchat/ola/vn/message/f;->x:S

    const/4 v1, 0x4

    const/16 v3, 0x21

    if-eq v0, v1, :cond_6

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    invoke-direct {p0}, Lchat/ola/vn/message/f;->Z()Ljava/lang/CharSequence;

    move-result-object v0

    new-instance v1, Landroid/text/SpannableStringBuilder;

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v1, v4}, Landroid/text/SpannableStringBuilder;-><init>(Ljava/lang/CharSequence;)V

    iput-object v1, p0, Lchat/ola/vn/message/f;->ad:Ljava/lang/CharSequence;

    iget-object v1, p0, Lchat/ola/vn/message/f;->ad:Ljava/lang/CharSequence;

    check-cast v1, Landroid/text/SpannableStringBuilder;

    new-instance v4, Landroid/text/style/ForegroundColorSpan;

    sget v5, Lchat/ola/vn/f;->y:I

    invoke-direct {v4, v5}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    iget-object v5, p0, Lchat/ola/vn/message/f;->ad:Ljava/lang/CharSequence;

    invoke-interface {v5}, Ljava/lang/CharSequence;->length()I

    move-result v5

    invoke-virtual {v1, v4, v2, v5, v3}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    :cond_2
    :goto_2
    iput-object v0, p0, Lchat/ola/vn/message/f;->ae:Ljava/lang/CharSequence;

    return-void

    :pswitch_1
    const-string v0, ""

    invoke-direct {p0, v0}, Lchat/ola/vn/message/f;->p(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v0

    new-instance v1, Landroid/text/SpannableStringBuilder;

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v1, v4}, Landroid/text/SpannableStringBuilder;-><init>(Ljava/lang/CharSequence;)V

    iput-object v1, p0, Lchat/ola/vn/message/f;->ad:Ljava/lang/CharSequence;

    iget-object v1, p0, Lchat/ola/vn/message/f;->ad:Ljava/lang/CharSequence;

    check-cast v1, Landroid/text/SpannableStringBuilder;

    new-instance v4, Landroid/text/style/ForegroundColorSpan;

    sget v5, Lchat/ola/vn/f;->y:I

    invoke-direct {v4, v5}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v5

    invoke-virtual {v1, v4, v2, v5, v3}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    goto :goto_2

    :pswitch_2
    const-string v0, ""

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->f()J

    move-result-wide v4

    const-wide/16 v6, 0x0

    cmp-long v1, v4, v6

    if-eqz v1, :cond_3

    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v1

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->f()J

    move-result-wide v4

    invoke-virtual {v1, v4, v5}, Ljava/util/Calendar;->setTimeInMillis(J)V

    const/4 v4, 0x5

    invoke-virtual {v1, v4}, Ljava/util/Calendar;->get(I)I

    move-result v4

    const/4 v5, 0x2

    invoke-virtual {v1, v5}, Ljava/util/Calendar;->get(I)I

    move-result v1

    add-int/lit8 v1, v1, 0x1

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, "("

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v0, "/"

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v0, ") "

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :cond_3
    invoke-virtual {p0}, Lchat/ola/vn/message/f;->q()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_4

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->q()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :cond_4
    invoke-direct {p0, v0}, Lchat/ola/vn/message/f;->p(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, " \u00b7 "

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    invoke-virtual {p0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_5

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v4
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-object v1, v4

    :catch_0
    :cond_5
    :try_start_2
    new-instance v4, Landroid/text/SpannableStringBuilder;

    invoke-direct {v4, v1}, Landroid/text/SpannableStringBuilder;-><init>(Ljava/lang/CharSequence;)V

    iput-object v4, p0, Lchat/ola/vn/message/f;->ad:Ljava/lang/CharSequence;

    iget-object v4, p0, Lchat/ola/vn/message/f;->ad:Ljava/lang/CharSequence;

    check-cast v4, Landroid/text/SpannableStringBuilder;

    new-instance v5, Landroid/text/style/ForegroundColorSpan;

    sget v6, Lchat/ola/vn/f;->y:I

    invoke-direct {v5, v6}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v6

    invoke-virtual {v4, v5, v2, v6, v3}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v4

    if-le v2, v4, :cond_2

    iget-object v2, p0, Lchat/ola/vn/message/f;->ad:Ljava/lang/CharSequence;

    check-cast v2, Landroid/text/SpannableStringBuilder;

    new-instance v4, Landroid/text/style/ForegroundColorSpan;

    sget v5, Lchat/ola/vn/f;->z:I

    invoke-direct {v4, v5}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v5

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {v2, v4, v5, v1, v3}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    goto/16 :goto_2

    :cond_6
    invoke-direct {p0}, Lchat/ola/vn/message/f;->aa()Ljava/lang/CharSequence;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/f;->ae:Ljava/lang/CharSequence;

    new-instance v0, Landroid/text/SpannableStringBuilder;

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/text/SpannableStringBuilder;-><init>(Ljava/lang/CharSequence;)V

    iput-object v0, p0, Lchat/ola/vn/message/f;->ad:Ljava/lang/CharSequence;

    iget-object v0, p0, Lchat/ola/vn/message/f;->ad:Ljava/lang/CharSequence;

    check-cast v0, Landroid/text/SpannableStringBuilder;

    new-instance v1, Landroid/text/style/ForegroundColorSpan;

    sget v4, Lchat/ola/vn/f;->C:I

    invoke-direct {v1, v4}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    iget-object v4, p0, Lchat/ola/vn/message/f;->ad:Ljava/lang/CharSequence;

    invoke-interface {v4}, Ljava/lang/CharSequence;->length()I

    move-result v4

    invoke-virtual {v0, v1, v2, v4, v3}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    return-void

    :catch_1
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public K()I
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method public L()Ljava/lang/CharSequence;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/f;->ad:Ljava/lang/CharSequence;

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->J()V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/message/f;->ad:Ljava/lang/CharSequence;

    return-object v0
.end method

.method public M()Ljava/lang/CharSequence;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/f;->ae:Ljava/lang/CharSequence;

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->J()V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/message/f;->ae:Ljava/lang/CharSequence;

    return-object v0
.end method

.method public N()Z
    .locals 6

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/message/f;->J:Ljava/lang/Long;

    const/4 v1, 0x1

    if-nez v0, :cond_0

    return v1

    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    iget-object v0, p0, Lchat/ola/vn/message/f;->J:Ljava/lang/Long;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v4

    cmp-long v0, v2, v4

    if-ltz v0, :cond_1

    return v1

    :cond_1
    const/4 v0, 0x0

    return v0
.end method

.method public O()Landroid/net/Uri;
    .locals 1

    invoke-static {}, Lchat/ola/vn/c/x;->d()Landroid/net/Uri;

    move-result-object v0

    return-object v0
.end method

.method public P()Z
    .locals 1

    invoke-static {}, Lchat/ola/vn/c/x;->f()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/message/f;->aa:Ljava/lang/Boolean;

    if-nez v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/message/f;->aa:Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    return v0

    :cond_1
    const/4 v0, 0x0

    return v0
.end method

.method public Q()Lchat/ola/vn/game/caro/b;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/f;->ah:Lchat/ola/vn/game/caro/b;

    return-object v0
.end method

.method public R()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/f;->ah:Lchat/ola/vn/game/caro/b;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/message/f;->ah:Lchat/ola/vn/game/caro/b;

    invoke-virtual {v0}, Lchat/ola/vn/game/caro/b;->h()V

    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/message/f;->ah:Lchat/ola/vn/game/caro/b;

    return-void
.end method

.method public S()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/message/f;->ai:Z

    return v0
.end method

.method public T()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/f;->P:Ljava/lang/String;

    return-object v0
.end method

.method public U()I
    .locals 1

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/message/f;->y()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/16 v0, 0x64

    return v0
.end method

.method public V()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/message/f;->ag:Z

    return v0
.end method

.method public W()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public X()Z
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/message/f;->d:Ljava/lang/String;

    const-string v1, ".chatgroup."

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    return v0

    :catch_0
    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public a()J
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/message/f;->S:Lchat/ola/vn/message/d;

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->m()J

    move-result-wide v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-wide v0

    :catch_0
    iget-wide v0, p0, Lchat/ola/vn/message/f;->M:J

    return-wide v0
.end method

.method public a(Z)Ljava/util/List;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(Z)",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;"
        }
    .end annotation

    if-eqz p1, :cond_0

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lchat/ola/vn/message/f;->a:J

    sub-long v4, v0, v2

    const-wide/32 v0, 0xdbba0

    cmp-long p1, v4, v0

    if-ltz p1, :cond_0

    const/4 p1, 0x0

    return-object p1

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/message/f;->c:Ljava/util/List;

    return-object p1
.end method

.method public a(B)V
    .locals 1

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/message/f;->ae:Ljava/lang/CharSequence;

    iput-byte p1, p0, Lchat/ola/vn/message/f;->y:B

    return-void
.end method

.method public a(I)V
    .locals 3

    iget v0, p0, Lchat/ola/vn/message/f;->b:I

    if-eq v0, p1, :cond_3

    iput p1, p0, Lchat/ola/vn/message/f;->b:I

    iget v0, p0, Lchat/ola/vn/message/f;->b:I

    const/4 v1, 0x0

    if-gez v0, :cond_0

    iput v1, p0, Lchat/ola/vn/message/f;->b:I

    :cond_0
    iget v0, p0, Lchat/ola/vn/message/f;->b:I

    if-lez v0, :cond_1

    iput-boolean v1, p0, Lchat/ola/vn/message/f;->B:Z

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    invoke-virtual {v0, p0}, Lchat/ola/vn/message/g;->i(Lchat/ola/vn/message/f;)V

    :cond_2
    :try_start_0
    sget-object v0, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    iget-object v1, p0, Lchat/ola/vn/message/f;->d:Ljava/lang/String;

    iget-short v2, p0, Lchat/ola/vn/message/f;->x:S

    invoke-virtual {v0, v1, v2, p1}, Lchat/ola/vn/balloon/OlaBalloonService;->a(Ljava/lang/String;SI)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-direct {p0}, Lchat/ola/vn/message/f;->Y()V

    :cond_3
    return-void
.end method

.method public a(J)V
    .locals 0

    iput-wide p1, p0, Lchat/ola/vn/message/f;->o:J

    return-void
.end method

.method public a(Lchat/ola/vn/message/d;)V
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lchat/ola/vn/message/f;->a(Lchat/ola/vn/message/d;Z)V

    return-void
.end method

.method a(Lchat/ola/vn/message/d;BB)V
    .locals 1

    iget v0, p0, Lchat/ola/vn/message/f;->b:I

    if-lez v0, :cond_1

    const/4 v0, 0x3

    if-ne p3, v0, :cond_1

    iget v0, p0, Lchat/ola/vn/message/f;->b:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lchat/ola/vn/message/f;->b:I

    iget v0, p0, Lchat/ola/vn/message/f;->b:I

    if-gez v0, :cond_0

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/message/f;->b:I

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/message/f;->Y()V

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/message/g;->a(Lchat/ola/vn/message/d;BB)V

    :cond_2
    return-void
.end method

.method public a(Lchat/ola/vn/message/d;IZ)V
    .locals 3

    if-nez p1, :cond_0

    return-void

    :cond_0
    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    if-nez v0, :cond_1

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/message/f;->aj:Ljava/util/Map;

    if-nez v0, :cond_2

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/message/f;->aj:Ljava/util/Map;

    :cond_2
    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->m()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/util/Calendar;->setTimeInMillis(J)V

    const/4 v1, 0x5

    invoke-virtual {v0, v1}, Ljava/util/Calendar;->get(I)I

    move-result v1

    const/4 v2, 0x2

    invoke-virtual {v0, v2}, Ljava/util/Calendar;->get(I)I

    move-result v0

    iget v2, p0, Lchat/ola/vn/message/f;->X:I

    if-gez v2, :cond_3

    iput v1, p0, Lchat/ola/vn/message/f;->X:I

    :cond_3
    iget v2, p0, Lchat/ola/vn/message/f;->Y:I

    if-gez v2, :cond_4

    iput v0, p0, Lchat/ola/vn/message/f;->Y:I

    :cond_4
    iget-object v2, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    if-lez v2, :cond_6

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->e()B

    move-result v2

    if-eqz v2, :cond_6

    iget v2, p0, Lchat/ola/vn/message/f;->X:I

    if-ne v1, v2, :cond_5

    iget v2, p0, Lchat/ola/vn/message/f;->Y:I

    if-eq v0, v2, :cond_6

    :cond_5
    iput v1, p0, Lchat/ola/vn/message/f;->X:I

    iput v0, p0, Lchat/ola/vn/message/f;->Y:I

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->m()J

    move-result-wide v0

    invoke-static {v0, v1}, Lchat/ola/vn/message/e;->a(J)Lchat/ola/vn/message/y;

    move-result-object v0

    iput-object p0, v0, Lchat/ola/vn/message/d;->a:Lchat/ola/vn/message/f;

    iget-object v1, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_6
    invoke-virtual {p1}, Lchat/ola/vn/message/d;->e()B

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-nez v0, :cond_8

    :try_start_1
    iget-object p2, p0, Lchat/ola/vn/message/f;->T:Lchat/ola/vn/message/d;

    if-eqz p2, :cond_7

    iget-object p2, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    iget-object p3, p0, Lchat/ola/vn/message/f;->T:Lchat/ola/vn/message/d;

    invoke-interface {p2, p3}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    iget-object p2, p0, Lchat/ola/vn/message/f;->T:Lchat/ola/vn/message/d;

    invoke-virtual {p2, p1}, Lchat/ola/vn/message/d;->a(Lchat/ola/vn/message/d;)V

    goto :goto_0

    :cond_7
    iput-object p1, p0, Lchat/ola/vn/message/f;->T:Lchat/ola/vn/message/d;

    :goto_0
    iget-object p2, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    iget-object p3, p0, Lchat/ola/vn/message/f;->T:Lchat/ola/vn/message/d;

    invoke-interface {p2, p3}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    const/4 p2, 0x0

    goto :goto_3

    :cond_8
    :try_start_2
    iget-object v0, p1, Lchat/ola/vn/message/d;->l:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_9

    iget-object v0, p0, Lchat/ola/vn/message/f;->aj:Ljava/util/Map;

    iget-object v1, p1, Lchat/ola/vn/message/d;->l:Ljava/lang/String;

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/message/d;

    if-nez v0, :cond_a

    iget-object p3, p0, Lchat/ola/vn/message/f;->aj:Ljava/util/Map;

    iget-object v0, p1, Lchat/ola/vn/message/d;->l:Ljava/lang/String;

    invoke-interface {p3, v0, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    if-ltz p2, :cond_9

    iget-object p3, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    invoke-interface {p3, p2, p1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    goto :goto_2

    :cond_9
    iget-object p2, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    invoke-interface {p2, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_2

    :cond_a
    if-eqz p3, :cond_c

    iget-object p3, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    invoke-interface {p3, v0}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    if-ltz p2, :cond_b

    iget-object p3, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    invoke-interface {p3, p2, p1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    goto :goto_1

    :cond_b
    iget-object p2, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    invoke-interface {p2, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :goto_1
    iget-object p2, p0, Lchat/ola/vn/message/f;->aj:Ljava/util/Map;

    iget-object p3, p1, Lchat/ola/vn/message/d;->l:Ljava/lang/String;

    invoke-interface {p2, p3, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_c
    :goto_2
    iget-object p2, p0, Lchat/ola/vn/message/f;->S:Lchat/ola/vn/message/d;

    iput-object p1, p0, Lchat/ola/vn/message/f;->S:Lchat/ola/vn/message/d;

    :goto_3
    iput-object p0, p1, Lchat/ola/vn/message/d;->a:Lchat/ola/vn/message/f;

    iget-object p3, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    if-eqz p3, :cond_d

    iget-object p3, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    invoke-virtual {p3}, Lchat/ola/vn/message/g;->t()V

    :cond_d
    iget-object p3, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    invoke-virtual {p3, p0}, Lchat/ola/vn/message/g;->f(Lchat/ola/vn/message/f;)Z

    move-result p3

    const/4 v0, 0x0

    if-nez p3, :cond_f

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->d()B

    move-result p3

    const/4 v1, 0x1

    if-ne p3, v1, :cond_f

    iget-byte p3, p0, Lchat/ola/vn/message/f;->af:B

    sub-int/2addr p3, v1

    int-to-byte p3, p3

    iput-byte p3, p0, Lchat/ola/vn/message/f;->af:B

    iget-byte p3, p0, Lchat/ola/vn/message/f;->af:B

    if-gez p3, :cond_e

    iput-byte v0, p0, Lchat/ola/vn/message/f;->af:B

    :cond_e
    iget p3, p0, Lchat/ola/vn/message/f;->b:I

    add-int/2addr p3, v1

    invoke-virtual {p0, p3}, Lchat/ola/vn/message/f;->a(I)V

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/message/f;->a(Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;)V

    goto :goto_4

    :cond_f
    invoke-virtual {p0, v0}, Lchat/ola/vn/message/f;->a(I)V

    :goto_4
    iget-object p2, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    if-eqz p2, :cond_10

    iget-object p2, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    invoke-virtual {p2, p0, p1}, Lchat/ola/vn/message/g;->a(Lchat/ola/vn/message/f;Lchat/ola/vn/message/d;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_10
    return-void
.end method

.method public a(Lchat/ola/vn/message/d;Z)V
    .locals 1

    const/4 v0, -0x1

    invoke-virtual {p0, p1, v0, p2}, Lchat/ola/vn/message/f;->a(Lchat/ola/vn/message/d;IZ)V

    return-void
.end method

.method public a(Lchat/ola/vn/message/f;)V
    .locals 5

    if-nez p1, :cond_0

    return-void

    :cond_0
    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;S)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/f;->d:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/f;->e:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->n()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/f;->f:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->d()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/f;->g:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->e()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/f;->h:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->o()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/f;->i:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->p()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/f;->j:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->q()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/f;->k:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->s()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/f;->l:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->t()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/f;->m:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->f()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-eqz v4, :cond_1

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->f()J

    move-result-wide v0

    iput-wide v0, p0, Lchat/ola/vn/message/f;->o:J

    :cond_1
    invoke-virtual {p1}, Lchat/ola/vn/message/f;->h()S

    move-result v0

    iput-short v0, p0, Lchat/ola/vn/message/f;->v:S

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->i()S

    move-result v0

    iput-short v0, p0, Lchat/ola/vn/message/f;->w:S

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    iput-short v0, p0, Lchat/ola/vn/message/f;->x:S

    iget-short v0, p0, Lchat/ola/vn/message/f;->x:S

    const/4 v1, 0x4

    if-le v0, v1, :cond_2

    const/4 v0, 0x0

    iput-short v0, p0, Lchat/ola/vn/message/f;->x:S

    :cond_2
    invoke-virtual {p1}, Lchat/ola/vn/message/f;->r()B

    move-result v0

    iput-byte v0, p0, Lchat/ola/vn/message/f;->y:B

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->u()B

    move-result v0

    iput-byte v0, p0, Lchat/ola/vn/message/f;->z:B

    iget-object v0, p0, Lchat/ola/vn/message/f;->d:Ljava/lang/String;

    iget-short v1, p0, Lchat/ola/vn/message/f;->x:S

    invoke-static {v0, v1}, Lchat/ola/vn/message/f;->b(Ljava/lang/String;S)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/f;->U:Ljava/lang/String;

    iget-short v0, p0, Lchat/ola/vn/message/f;->x:S

    const/4 v1, 0x1

    if-ne v0, v1, :cond_3

    const/4 v0, 0x2

    iput-byte v0, p0, Lchat/ola/vn/message/f;->V:B

    :cond_3
    invoke-virtual {p1}, Lchat/ola/vn/message/f;->g()S

    move-result v0

    invoke-virtual {p0, v0}, Lchat/ola/vn/message/f;->a(S)V

    iget-object v0, p1, Lchat/ola/vn/message/f;->Z:Ljava/lang/Boolean;

    iput-object v0, p0, Lchat/ola/vn/message/f;->Z:Ljava/lang/Boolean;

    iget-object v0, p1, Lchat/ola/vn/message/f;->ab:Ljava/lang/Long;

    iput-object v0, p0, Lchat/ola/vn/message/f;->ab:Ljava/lang/Long;

    iget-boolean v0, p1, Lchat/ola/vn/message/f;->ac:Z

    iput-boolean v0, p0, Lchat/ola/vn/message/f;->ac:Z

    iget-object v0, p1, Lchat/ola/vn/message/f;->K:Ljava/lang/Long;

    iput-object v0, p0, Lchat/ola/vn/message/f;->K:Ljava/lang/Long;

    iget-wide v0, p1, Lchat/ola/vn/message/f;->L:J

    iput-wide v0, p0, Lchat/ola/vn/message/f;->L:J

    iget-object v0, p1, Lchat/ola/vn/message/f;->S:Lchat/ola/vn/message/d;

    if-eqz v0, :cond_4

    iget-object v0, p1, Lchat/ola/vn/message/f;->S:Lchat/ola/vn/message/d;

    iput-object v0, p0, Lchat/ola/vn/message/f;->S:Lchat/ola/vn/message/d;

    :cond_4
    iget-boolean v0, p1, Lchat/ola/vn/message/f;->I:Z

    if-eqz v0, :cond_5

    iget-boolean v0, p1, Lchat/ola/vn/message/f;->I:Z

    iput-boolean v0, p0, Lchat/ola/vn/message/f;->I:Z

    :cond_5
    iget-boolean v0, p0, Lchat/ola/vn/message/f;->B:Z

    if-eqz v0, :cond_6

    iget-boolean v0, p1, Lchat/ola/vn/message/f;->B:Z

    iput-boolean v0, p0, Lchat/ola/vn/message/f;->B:Z

    :cond_6
    iget-boolean v0, p0, Lchat/ola/vn/message/f;->ag:Z

    if-nez v0, :cond_7

    iget-boolean v0, p1, Lchat/ola/vn/message/f;->ag:Z

    iput-boolean v0, p0, Lchat/ola/vn/message/f;->ag:Z

    :cond_7
    iget-wide v0, p0, Lchat/ola/vn/message/f;->N:J

    cmp-long v4, v0, v2

    if-nez v4, :cond_8

    iget-wide v0, p1, Lchat/ola/vn/message/f;->N:J

    iput-wide v0, p0, Lchat/ola/vn/message/f;->N:J

    :cond_8
    iget-wide v0, p0, Lchat/ola/vn/message/f;->M:J

    cmp-long v4, v0, v2

    if-nez v4, :cond_9

    iget-wide v0, p1, Lchat/ola/vn/message/f;->M:J

    iput-wide v0, p0, Lchat/ola/vn/message/f;->M:J

    :cond_9
    iget-object v0, p0, Lchat/ola/vn/message/f;->J:Ljava/lang/Long;

    if-nez v0, :cond_a

    iget-object p1, p1, Lchat/ola/vn/message/f;->J:Ljava/lang/Long;

    iput-object p1, p0, Lchat/ola/vn/message/f;->J:Ljava/lang/Long;

    :cond_a
    invoke-virtual {p0}, Lchat/ola/vn/message/f;->J()V

    return-void
.end method

.method public a(Ljava/lang/Boolean;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/f;->Z:Ljava/lang/Boolean;

    return-void
.end method

.method public a(Ljava/lang/Long;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/f;->ab:Ljava/lang/Long;

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 1

    iget-short v0, p0, Lchat/ola/vn/message/f;->x:S

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;S)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/message/f;->d:Ljava/lang/String;

    return-void
.end method

.method public a(Ljava/lang/String;Lchat/ola/vn/message/d;)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/message/f;->aj:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/message/d;

    if-eqz v0, :cond_0

    iget-object v1, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result v0

    if-ltz v0, :cond_0

    invoke-virtual {p0, p1}, Lchat/ola/vn/message/f;->l(Ljava/lang/String;)V

    const/4 p1, 0x0

    invoke-virtual {p0, p2, v0, p1}, Lchat/ola/vn/message/f;->a(Lchat/ola/vn/message/d;IZ)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;)V"
        }
    .end annotation

    if-eqz p1, :cond_0

    iput-object p1, p0, Lchat/ola/vn/message/f;->c:Ljava/util/List;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lchat/ola/vn/message/f;->a:J

    iget-object p1, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    if-eqz p1, :cond_2

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    invoke-virtual {p1, p0}, Lchat/ola/vn/message/g;->j(Lchat/ola/vn/message/f;)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/message/f;->c:Ljava/util/List;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/message/f;->c:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->clear()V

    :cond_1
    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/message/f;->c:Ljava/util/List;

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/message/f;->a:J

    iget-object p1, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    if-eqz p1, :cond_2

    goto :goto_0

    :cond_2
    return-void
.end method

.method public a(Ljava/util/List;Ljava/lang/String;)V
    .locals 12
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/d;",
            ">;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    :try_start_0
    iput-object p2, p0, Lchat/ola/vn/message/f;->P:Ljava/lang/String;

    const/4 v0, 0x0

    const/4 v1, 0x1

    const/4 v2, 0x2

    if-eqz p1, :cond_e

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v3

    if-lez v3, :cond_e

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v3

    iget-object v4, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    if-nez v4, :cond_0

    new-instance v4, Ljava/util/ArrayList;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v5

    mul-int/lit8 v5, v5, 0x2

    invoke-direct {v4, v5}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v4, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    :cond_0
    iget-object v4, p0, Lchat/ola/vn/message/f;->aj:Ljava/util/Map;

    if-nez v4, :cond_1

    new-instance v4, Ljava/util/HashMap;

    invoke-direct {v4}, Ljava/util/HashMap;-><init>()V

    iput-object v4, p0, Lchat/ola/vn/message/f;->aj:Ljava/util/Map;

    :cond_1
    new-instance v4, Ljava/util/ArrayList;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v5

    iget-object v6, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    invoke-interface {v6}, Ljava/util/List;->size()I

    move-result v6

    add-int/2addr v5, v6

    invoke-direct {v4, v5}, Ljava/util/ArrayList;-><init>(I)V

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v5

    const/4 v6, 0x0

    :goto_0
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    const/4 v8, 0x5

    if-eqz v7, :cond_a

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lchat/ola/vn/message/d;

    invoke-virtual {v7}, Lchat/ola/vn/message/d;->e()B

    move-result v9
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_4

    if-nez v9, :cond_3

    :try_start_1
    iget-object v8, p0, Lchat/ola/vn/message/f;->T:Lchat/ola/vn/message/d;

    if-eqz v8, :cond_2

    iget-object v8, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    iget-object v9, p0, Lchat/ola/vn/message/f;->T:Lchat/ola/vn/message/d;

    invoke-interface {v8, v9}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    iget-object v8, p0, Lchat/ola/vn/message/f;->T:Lchat/ola/vn/message/d;

    invoke-virtual {v8, v7}, Lchat/ola/vn/message/d;->a(Lchat/ola/vn/message/d;)V

    goto/16 :goto_1

    :cond_2
    iput-object v7, p0, Lchat/ola/vn/message/f;->T:Lchat/ola/vn/message/d;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1

    :cond_3
    :try_start_2
    invoke-virtual {v7}, Lchat/ola/vn/message/d;->d()B

    move-result v9

    if-eqz v9, :cond_7

    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v9

    invoke-virtual {v7}, Lchat/ola/vn/message/d;->m()J

    move-result-wide v10

    invoke-virtual {v9, v10, v11}, Ljava/util/Calendar;->setTimeInMillis(J)V

    invoke-virtual {v9, v8}, Ljava/util/Calendar;->get(I)I

    move-result v8

    invoke-virtual {v9, v2}, Ljava/util/Calendar;->get(I)I

    move-result v9

    iget v10, p0, Lchat/ola/vn/message/f;->X:I

    if-gez v10, :cond_4

    iput v8, p0, Lchat/ola/vn/message/f;->X:I

    :cond_4
    iget v10, p0, Lchat/ola/vn/message/f;->Y:I

    if-gez v10, :cond_5

    iput v9, p0, Lchat/ola/vn/message/f;->Y:I

    :cond_5
    iget-object v10, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    invoke-interface {v10}, Ljava/util/List;->size()I

    move-result v10

    if-lez v10, :cond_7

    invoke-virtual {v7}, Lchat/ola/vn/message/d;->e()B

    move-result v10

    if-eqz v10, :cond_7

    iget v10, p0, Lchat/ola/vn/message/f;->X:I

    if-ne v8, v10, :cond_6

    iget v10, p0, Lchat/ola/vn/message/f;->Y:I

    if-eq v9, v10, :cond_7

    :cond_6
    iput v8, p0, Lchat/ola/vn/message/f;->X:I

    iput v9, p0, Lchat/ola/vn/message/f;->Y:I

    invoke-virtual {v7}, Lchat/ola/vn/message/d;->m()J

    move-result-wide v8

    invoke-static {v8, v9}, Lchat/ola/vn/message/e;->a(J)Lchat/ola/vn/message/y;

    move-result-object v8

    iput-object p0, v8, Lchat/ola/vn/message/d;->a:Lchat/ola/vn/message/f;

    invoke-interface {v4, v8}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_7
    iget-object v8, v7, Lchat/ola/vn/message/d;->l:Ljava/lang/String;

    invoke-static {v8}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v8

    if-nez v8, :cond_9

    iget-object v8, p0, Lchat/ola/vn/message/f;->aj:Ljava/util/Map;

    iget-object v9, v7, Lchat/ola/vn/message/d;->l:Ljava/lang/String;

    invoke-interface {v8, v9}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Lchat/ola/vn/message/d;

    if-nez v8, :cond_8

    iget-object v6, p0, Lchat/ola/vn/message/f;->aj:Ljava/util/Map;

    iget-object v8, v7, Lchat/ola/vn/message/d;->l:Ljava/lang/String;

    invoke-interface {v6, v8, v7}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-interface {v4, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const/4 v6, 0x1

    goto :goto_1

    :cond_8
    iget-byte v9, v7, Lchat/ola/vn/message/d;->u:B

    invoke-virtual {v8, v9}, Lchat/ola/vn/message/d;->a(B)V

    :catch_0
    :cond_9
    :goto_1
    iput-object p0, v7, Lchat/ola/vn/message/d;->a:Lchat/ola/vn/message/f;

    goto/16 :goto_0

    :cond_a
    if-nez v6, :cond_b

    invoke-interface {v4}, Ljava/util/List;->clear()V

    :cond_b
    iget-object v5, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v5
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_4

    if-lez v5, :cond_d

    :try_start_3
    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v5

    if-lez v5, :cond_c

    iget-object v5, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    invoke-interface {v5, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/message/d;

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->e()B

    move-result v5

    const/4 v6, 0x4

    if-ne v5, v6, :cond_c

    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v5

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->m()J

    move-result-wide v9

    invoke-virtual {v5, v9, v10}, Ljava/util/Calendar;->setTimeInMillis(J)V

    invoke-virtual {v5, v8}, Ljava/util/Calendar;->get(I)I

    move-result v7

    invoke-virtual {v5, v2}, Ljava/util/Calendar;->get(I)I

    move-result v9

    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v10

    sub-int/2addr v10, v1

    invoke-interface {v4, v10}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Lchat/ola/vn/message/d;

    invoke-virtual {v10}, Lchat/ola/vn/message/d;->m()J

    move-result-wide v10

    invoke-virtual {v5, v10, v11}, Ljava/util/Calendar;->setTimeInMillis(J)V

    invoke-virtual {v5, v8}, Ljava/util/Calendar;->get(I)I

    move-result v8

    invoke-virtual {v5, v2}, Ljava/util/Calendar;->get(I)I

    move-result v5

    if-ne v8, v7, :cond_c

    if-ne v5, v9, :cond_c

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->e()B

    move-result v5

    if-ne v5, v6, :cond_c

    iget-object v5, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    invoke-interface {v5, v0}, Ljava/util/List;->remove(Ljava/lang/Object;)Z
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_2

    :catch_1
    move-exception v0

    :try_start_4
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_c
    :goto_2
    iget-object v0, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    invoke-interface {v4, v0}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    :cond_d
    iput-object v4, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_4

    move v0, v3

    :cond_e
    :try_start_5
    iget-object v3, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    iget-object v4, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v4

    sub-int/2addr v4, v1

    invoke-interface {v3, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/message/d;

    iput-object v3, p0, Lchat/ola/vn/message/f;->S:Lchat/ola/vn/message/d;
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_2

    :try_start_6
    iget-object v3, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    sub-int/2addr v3, v1

    :goto_3
    if-ltz v3, :cond_11

    iget-object v4, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    invoke-interface {v4, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/message/d;

    invoke-virtual {v4}, Lchat/ola/vn/message/d;->d()B

    move-result v5

    if-eq v5, v1, :cond_10

    invoke-virtual {v4}, Lchat/ola/vn/message/d;->d()B

    move-result v5

    if-ne v5, v2, :cond_f

    goto :goto_4

    :cond_f
    add-int/lit8 v3, v3, -0x1

    goto :goto_3

    :cond_10
    :goto_4
    iput-object v4, p0, Lchat/ola/vn/message/f;->S:Lchat/ola/vn/message/d;
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_3

    goto :goto_5

    :catch_2
    const/4 v1, 0x0

    :try_start_7
    iput-object v1, p0, Lchat/ola/vn/message/f;->S:Lchat/ola/vn/message/d;

    :catch_3
    :cond_11
    :goto_5
    iget-object v1, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    if-eqz v1, :cond_12

    iget-object v1, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    invoke-virtual {v1}, Lchat/ola/vn/message/g;->t()V

    iget-object v1, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    invoke-virtual {v1, p0, v0, p2, p1}, Lchat/ola/vn/message/g;->a(Lchat/ola/vn/message/f;ILjava/lang/String;Ljava/util/List;)V
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_4

    :catch_4
    :cond_12
    return-void
.end method

.method public a(S)V
    .locals 1

    iget-short v0, p0, Lchat/ola/vn/message/f;->u:S

    if-eq v0, p1, :cond_0

    invoke-virtual {p0, p1}, Lchat/ola/vn/message/f;->b(S)V

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->J()V

    iget-object p1, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    invoke-virtual {p1, p0}, Lchat/ola/vn/message/g;->j(Lchat/ola/vn/message/f;)V

    :cond_0
    return-void
.end method

.method public a(ZZ)V
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/message/f;->ag:Z

    if-eq v0, p1, :cond_0

    iput-boolean p1, p0, Lchat/ola/vn/message/f;->ag:Z

    if-eqz p2, :cond_0

    :try_start_0
    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1}, Lchat/ola/vn/message/g;->p()Ljava/util/List;

    move-result-object p1

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/h/b;->b(Ljava/lang/String;Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public a(Ljava/lang/String;S)Z
    .locals 1

    :try_start_0
    iget-short v0, p0, Lchat/ola/vn/message/f;->x:S

    if-ne v0, p2, :cond_1

    if-nez p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/message/f;->d:Ljava/lang/String;

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    return p1

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/message/f;->d:Ljava/lang/String;

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return p1

    :catch_0
    :cond_1
    const/4 p1, 0x0

    return p1
.end method

.method public b(I)Lchat/ola/vn/message/d;
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/d;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public b()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/f;->e:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/message/f;->d:Ljava/lang/String;

    return-object v0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/message/f;->e:Ljava/lang/String;

    return-object v0
.end method

.method public b(B)V
    .locals 1

    iget-byte v0, p0, Lchat/ola/vn/message/f;->z:B

    if-eq v0, p1, :cond_0

    iput-byte p1, p0, Lchat/ola/vn/message/f;->z:B

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/message/f;->ad:Ljava/lang/CharSequence;

    iput-object p1, p0, Lchat/ola/vn/message/f;->ae:Ljava/lang/CharSequence;

    :cond_0
    return-void
.end method

.method public b(J)V
    .locals 3

    const-wide/16 v0, 0x0

    cmp-long v2, p1, v0

    if-lez v2, :cond_1

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/message/f;->d(J)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iput-wide p1, p0, Lchat/ola/vn/message/f;->o:J

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/message/f;->ae:Ljava/lang/CharSequence;

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->J()V

    iget-object p1, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    invoke-virtual {p1, p0}, Lchat/ola/vn/message/g;->j(Lchat/ola/vn/message/f;)V

    :cond_1
    return-void
.end method

.method public b(Lchat/ola/vn/message/f;)V
    .locals 5

    if-nez p1, :cond_0

    return-void

    :cond_0
    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;S)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/f;->d:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/f;->e:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->n()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/f;->f:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->d()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/f;->g:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->e()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/f;->h:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->o()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/f;->i:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->p()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/f;->j:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->q()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/f;->k:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->s()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/f;->l:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->t()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/f;->m:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->f()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-eqz v4, :cond_1

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->f()J

    move-result-wide v0

    iput-wide v0, p0, Lchat/ola/vn/message/f;->o:J

    :cond_1
    invoke-virtual {p1}, Lchat/ola/vn/message/f;->h()S

    move-result v0

    iput-short v0, p0, Lchat/ola/vn/message/f;->v:S

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->i()S

    move-result v0

    iput-short v0, p0, Lchat/ola/vn/message/f;->w:S

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    iput-short v0, p0, Lchat/ola/vn/message/f;->x:S

    iget-short v0, p0, Lchat/ola/vn/message/f;->x:S

    const/4 v1, 0x4

    if-le v0, v1, :cond_2

    const/4 v0, 0x0

    iput-short v0, p0, Lchat/ola/vn/message/f;->x:S

    :cond_2
    invoke-virtual {p1}, Lchat/ola/vn/message/f;->r()B

    move-result v0

    iput-byte v0, p0, Lchat/ola/vn/message/f;->y:B

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->u()B

    move-result v0

    iput-byte v0, p0, Lchat/ola/vn/message/f;->z:B

    iget-object v0, p0, Lchat/ola/vn/message/f;->d:Ljava/lang/String;

    iget-short v1, p0, Lchat/ola/vn/message/f;->x:S

    invoke-static {v0, v1}, Lchat/ola/vn/message/f;->b(Ljava/lang/String;S)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/f;->U:Ljava/lang/String;

    iget-short v0, p0, Lchat/ola/vn/message/f;->x:S

    const/4 v1, 0x1

    if-ne v0, v1, :cond_3

    const/4 v0, 0x2

    iput-byte v0, p0, Lchat/ola/vn/message/f;->V:B

    :cond_3
    iget-short v0, p0, Lchat/ola/vn/message/f;->u:S

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->g()S

    move-result v1

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->g()S

    move-result v0

    iput-short v0, p0, Lchat/ola/vn/message/f;->u:S

    iget-object v0, p1, Lchat/ola/vn/message/f;->S:Lchat/ola/vn/message/d;

    if-eqz v0, :cond_4

    iget-object v0, p1, Lchat/ola/vn/message/f;->S:Lchat/ola/vn/message/d;

    iput-object v0, p0, Lchat/ola/vn/message/f;->S:Lchat/ola/vn/message/d;

    :cond_4
    iget-boolean v0, p1, Lchat/ola/vn/message/f;->I:Z

    if-eqz v0, :cond_5

    iget-boolean v0, p1, Lchat/ola/vn/message/f;->I:Z

    iput-boolean v0, p0, Lchat/ola/vn/message/f;->I:Z

    :cond_5
    iget-boolean v0, p0, Lchat/ola/vn/message/f;->B:Z

    if-eqz v0, :cond_6

    iget-boolean v0, p1, Lchat/ola/vn/message/f;->B:Z

    iput-boolean v0, p0, Lchat/ola/vn/message/f;->B:Z

    :cond_6
    iget-boolean v0, p0, Lchat/ola/vn/message/f;->ag:Z

    if-nez v0, :cond_7

    iget-boolean v0, p1, Lchat/ola/vn/message/f;->ag:Z

    iput-boolean v0, p0, Lchat/ola/vn/message/f;->ag:Z

    :cond_7
    iget-wide v0, p0, Lchat/ola/vn/message/f;->N:J

    cmp-long v4, v0, v2

    if-nez v4, :cond_8

    iget-wide v0, p1, Lchat/ola/vn/message/f;->N:J

    iput-wide v0, p0, Lchat/ola/vn/message/f;->N:J

    :cond_8
    iget-wide v0, p0, Lchat/ola/vn/message/f;->M:J

    cmp-long v4, v0, v2

    if-nez v4, :cond_9

    iget-wide v0, p1, Lchat/ola/vn/message/f;->M:J

    iput-wide v0, p0, Lchat/ola/vn/message/f;->M:J

    :cond_9
    iget-object v0, p0, Lchat/ola/vn/message/f;->J:Ljava/lang/Long;

    if-nez v0, :cond_a

    iget-object p1, p1, Lchat/ola/vn/message/f;->J:Ljava/lang/Long;

    iput-object p1, p0, Lchat/ola/vn/message/f;->J:Ljava/lang/Long;

    :cond_a
    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/message/f;->ad:Ljava/lang/CharSequence;

    iput-object p1, p0, Lchat/ola/vn/message/f;->ae:Ljava/lang/CharSequence;

    return-void
.end method

.method public b(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/f;->e:Ljava/lang/String;

    invoke-static {v0, p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iput-object p1, p0, Lchat/ola/vn/message/f;->e:Ljava/lang/String;

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/message/f;->ad:Ljava/lang/CharSequence;

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->J()V

    iget-object p1, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    invoke-virtual {p1, p0}, Lchat/ola/vn/message/g;->j(Lchat/ola/vn/message/f;)V

    :cond_0
    return-void
.end method

.method b(Ljava/lang/String;Lchat/ola/vn/message/d;)V
    .locals 1

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/message/f;->aj:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p1, p0, Lchat/ola/vn/message/f;->aj:Ljava/util/Map;

    invoke-virtual {p2}, Lchat/ola/vn/message/d;->p()Ljava/lang/String;

    move-result-object v0

    invoke-interface {p1, v0, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public b(S)V
    .locals 2

    iget-short v0, p0, Lchat/ola/vn/message/f;->u:S

    if-eq v0, p1, :cond_1

    iput-short p1, p0, Lchat/ola/vn/message/f;->u:S

    const/4 v0, 0x2

    if-ne p1, v0, :cond_0

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/message/f;->N:J

    :cond_0
    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/message/f;->ad:Ljava/lang/CharSequence;

    iput-object p1, p0, Lchat/ola/vn/message/f;->ae:Ljava/lang/CharSequence;

    :cond_1
    return-void
.end method

.method public b(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/message/f;->ai:Z

    return-void
.end method

.method public c()Ljava/lang/String;
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/message/f;->e:Ljava/lang/String;

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "@"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lchat/ola/vn/message/f;->d:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/message/f;->e:Ljava/lang/String;

    return-object v0
.end method

.method public c(J)V
    .locals 3

    const-wide/16 v0, 0x0

    cmp-long v2, p1, v0

    if-lez v2, :cond_1

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/message/f;->d(J)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iput-wide p1, p0, Lchat/ola/vn/message/f;->o:J

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/message/f;->ad:Ljava/lang/CharSequence;

    iput-object p1, p0, Lchat/ola/vn/message/f;->ae:Ljava/lang/CharSequence;

    :cond_1
    return-void
.end method

.method public c(Ljava/lang/String;)V
    .locals 1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/message/f;->e:Ljava/lang/String;

    invoke-static {v0, p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    iput-object p1, p0, Lchat/ola/vn/message/f;->e:Ljava/lang/String;

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/message/f;->ad:Ljava/lang/CharSequence;

    iput-object p1, p0, Lchat/ola/vn/message/f;->ae:Ljava/lang/CharSequence;

    :cond_1
    return-void
.end method

.method public c(S)V
    .locals 0

    iput-short p1, p0, Lchat/ola/vn/message/f;->v:S

    return-void
.end method

.method public c(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/message/f;->I:Z

    return-void
.end method

.method public d()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/f;->g:Ljava/lang/String;

    return-object v0
.end method

.method public d(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/f;->g:Ljava/lang/String;

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/message/f;->h:Ljava/lang/String;

    iput-object p1, p0, Lchat/ola/vn/message/f;->ad:Ljava/lang/CharSequence;

    iput-object p1, p0, Lchat/ola/vn/message/f;->ae:Ljava/lang/CharSequence;

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->J()V

    return-void
.end method

.method public d(S)V
    .locals 0

    iput-short p1, p0, Lchat/ola/vn/message/f;->w:S

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->J()V

    return-void
.end method

.method public d(Z)V
    .locals 1

    const/4 v0, 0x1

    invoke-virtual {p0, p1, v0}, Lchat/ola/vn/message/f;->a(ZZ)V

    return-void
.end method

.method public e()Ljava/lang/String;
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/message/f;->h:Ljava/lang/String;

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/message/f;->g:Ljava/lang/String;

    const-string v1, ""

    invoke-static {v0, v1}, Lchat/ola/vn/util/i;->d(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/f;->h:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    const-string v0, ""

    iput-object v0, p0, Lchat/ola/vn/message/f;->h:Ljava/lang/String;

    :cond_0
    :goto_0
    iget-object v0, p0, Lchat/ola/vn/message/f;->h:Ljava/lang/String;

    return-object v0
.end method

.method public e(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/f;->g:Ljava/lang/String;

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/message/f;->h:Ljava/lang/String;

    iput-object p1, p0, Lchat/ola/vn/message/f;->ad:Ljava/lang/CharSequence;

    iput-object p1, p0, Lchat/ola/vn/message/f;->ae:Ljava/lang/CharSequence;

    return-void
.end method

.method public e(S)V
    .locals 0

    iput-short p1, p0, Lchat/ola/vn/message/f;->w:S

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/message/f;->ad:Ljava/lang/CharSequence;

    iput-object p1, p0, Lchat/ola/vn/message/f;->ae:Ljava/lang/CharSequence;

    return-void
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 3

    const/4 v0, 0x0

    if-nez p1, :cond_0

    return v0

    :cond_0
    :try_start_0
    check-cast p1, Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result v1

    iget-short v2, p0, Lchat/ola/vn/message/f;->x:S

    if-ne v1, v2, :cond_3

    iget-short v1, p0, Lchat/ola/vn/message/f;->x:S

    if-eqz v1, :cond_2

    iget-short v1, p0, Lchat/ola/vn/message/f;->x:S

    const/4 v2, 0x1

    if-ne v1, v2, :cond_1

    goto :goto_0

    :cond_1
    iget-object v1, p0, Lchat/ola/vn/message/f;->d:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p1

    invoke-static {v1, p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    return p1

    :cond_2
    :goto_0
    iget-object v1, p0, Lchat/ola/vn/message/f;->d:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p1

    invoke-static {v1, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return p1

    :catch_0
    :cond_3
    return v0
.end method

.method public f()J
    .locals 2

    iget-wide v0, p0, Lchat/ola/vn/message/f;->o:J

    return-wide v0
.end method

.method public f(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/f;->f:Ljava/lang/String;

    return-void
.end method

.method public f(S)V
    .locals 1

    iput-short p1, p0, Lchat/ola/vn/message/f;->x:S

    iget-short p1, p0, Lchat/ola/vn/message/f;->x:S

    const/4 v0, 0x4

    if-le p1, v0, :cond_0

    const/4 p1, 0x0

    iput-short p1, p0, Lchat/ola/vn/message/f;->x:S

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/message/f;->d:Ljava/lang/String;

    iget-short v0, p0, Lchat/ola/vn/message/f;->x:S

    invoke-static {p1, v0}, Lchat/ola/vn/message/f;->b(Ljava/lang/String;S)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/message/f;->U:Ljava/lang/String;

    return-void
.end method

.method public g()S
    .locals 1

    iget-short v0, p0, Lchat/ola/vn/message/f;->u:S

    return v0
.end method

.method public g(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/f;->i:Ljava/lang/String;

    return-void
.end method

.method public h()S
    .locals 1

    iget-short v0, p0, Lchat/ola/vn/message/f;->v:S

    return v0
.end method

.method public h(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/f;->j:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    invoke-virtual {p1, p0}, Lchat/ola/vn/message/g;->j(Lchat/ola/vn/message/f;)V

    :cond_0
    return-void
.end method

.method public i()S
    .locals 1

    iget-short v0, p0, Lchat/ola/vn/message/f;->w:S

    return v0
.end method

.method public i(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/f;->k:Ljava/lang/String;

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/message/f;->ad:Ljava/lang/CharSequence;

    iput-object p1, p0, Lchat/ola/vn/message/f;->ae:Ljava/lang/CharSequence;

    return-void
.end method

.method public j()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/f;->d:Ljava/lang/String;

    return-object v0
.end method

.method public j(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/f;->l:Ljava/lang/String;

    return-void
.end method

.method public k()S
    .locals 1

    iget-short v0, p0, Lchat/ola/vn/message/f;->x:S

    return v0
.end method

.method public k(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/f;->m:Ljava/lang/String;

    return-void
.end method

.method public l(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/message/f;->aj:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/d;

    if-eqz p1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/message/f;->W:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    iget-object v0, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    invoke-virtual {v0, p0, p1}, Lchat/ola/vn/message/g;->b(Lchat/ola/vn/message/f;Lchat/ola/vn/message/d;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public l()Z
    .locals 2

    iget-short v0, p0, Lchat/ola/vn/message/f;->x:S

    const/4 v1, 0x5

    if-eq v0, v1, :cond_0

    const/4 v1, 0x7

    if-eq v0, v1, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public m(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lchat/ola/vn/message/f;->s:J

    iget-short v0, p0, Lchat/ola/vn/message/f;->x:S

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "@"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :goto_0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/f;->n:Ljava/lang/String;

    goto :goto_1

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "@"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lchat/ola/vn/message/f;->d:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "@"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/message/f;->n:Ljava/lang/String;

    :goto_1
    iget-object p1, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    invoke-virtual {p1, p0}, Lchat/ola/vn/message/g;->g(Lchat/ola/vn/message/f;)V

    :cond_1
    return-void
.end method

.method public m()Z
    .locals 3

    iget-short v0, p0, Lchat/ola/vn/message/f;->x:S

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    const/4 v2, 0x7

    if-eq v0, v2, :cond_0

    packed-switch v0, :pswitch_data_0

    return v1

    :cond_0
    :pswitch_0
    const/4 v0, 0x0

    return v0

    :pswitch_data_0
    .packed-switch 0x4
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method public n()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/f;->f:Ljava/lang/String;

    return-object v0
.end method

.method public n(Ljava/lang/String;)V
    .locals 2

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/message/f;->s:J

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/message/f;->n:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/message/f;->A:Lchat/ola/vn/message/g;

    invoke-virtual {p1, p0}, Lchat/ola/vn/message/g;->h(Lchat/ola/vn/message/f;)V

    :cond_0
    return-void
.end method

.method public o(Ljava/lang/String;)Lchat/ola/vn/message/d;
    .locals 1

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/message/f;->aj:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/d;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    :cond_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public o()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/f;->i:Ljava/lang/String;

    return-object v0
.end method

.method public p()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/f;->j:Ljava/lang/String;

    return-object v0
.end method

.method public q()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/f;->k:Ljava/lang/String;

    return-object v0
.end method

.method public r()B
    .locals 1

    iget-byte v0, p0, Lchat/ola/vn/message/f;->y:B

    return v0
.end method

.method public s()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/f;->l:Ljava/lang/String;

    return-object v0
.end method

.method public t()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/f;->m:Ljava/lang/String;

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lchat/ola/vn/message/f;->d:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "#"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-short v1, p0, Lchat/ola/vn/message/f;->x:S

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public u()B
    .locals 1

    iget-byte v0, p0, Lchat/ola/vn/message/f;->z:B

    return v0
.end method

.method public v()J
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/message/f;->S:Lchat/ola/vn/message/d;

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->m()J

    move-result-wide v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-wide v0

    :catch_0
    const-wide/16 v0, 0x0

    return-wide v0
.end method

.method public w()Ljava/lang/String;
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/message/f;->S:Lchat/ola/vn/message/d;

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->k()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public x()Z
    .locals 6

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lchat/ola/vn/message/f;->r:J

    sub-long v4, v0, v2

    const-wide/32 v0, 0xdbba0

    cmp-long v2, v4, v0

    if-ltz v2, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->A()V

    :cond_0
    iget-byte v0, p0, Lchat/ola/vn/message/f;->af:B

    if-nez v0, :cond_1

    const/4 v0, 0x1

    return v0

    :cond_1
    const/4 v0, 0x0

    return v0
.end method

.method public y()Ljava/lang/String;
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/message/f;->U:Ljava/lang/String;

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/message/f;->d:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/message/f;->d:Ljava/lang/String;

    iget-short v1, p0, Lchat/ola/vn/message/f;->x:S

    invoke-static {v0, v1}, Lchat/ola/vn/message/f;->b(Ljava/lang/String;S)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/f;->U:Ljava/lang/String;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/message/f;->U:Ljava/lang/String;

    return-object v0
.end method

.method public z()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/message/f;->b:I

    return v0
.end method
