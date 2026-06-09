.class public Lchat/ola/vn/entity/i;
.super Ljava/lang/Object;


# static fields
.field static final a:[C

.field private static final v:[C


# instance fields
.field protected b:Ljava/lang/String;

.field protected c:Ljava/lang/String;

.field protected d:Ljava/lang/String;

.field protected e:Ljava/lang/String;

.field protected f:Ljava/lang/String;

.field protected g:Ljava/lang/String;

.field protected h:Ljava/lang/String;

.field protected i:Ljava/lang/String;

.field protected j:Ljava/lang/Long;

.field protected k:Ljava/lang/Long;

.field protected l:J

.field protected m:J

.field protected n:J

.field protected o:I

.field protected p:I

.field protected q:I

.field protected r:S

.field protected s:C

.field protected t:Z

.field protected u:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/i;",
            ">;"
        }
    .end annotation
.end field

.field private w:I


# direct methods
.method static constructor <clinit>()V
    .locals 2

    const/16 v0, 0x3e

    new-array v1, v0, [C

    fill-array-data v1, :array_0

    sput-object v1, Lchat/ola/vn/entity/i;->v:[C

    new-array v0, v0, [C

    fill-array-data v0, :array_1

    sput-object v0, Lchat/ola/vn/entity/i;->a:[C

    return-void

    nop

    :array_0
    .array-data 2
        0x30s
        0x31s
        0x32s
        0x33s
        0x34s
        0x35s
        0x36s
        0x37s
        0x38s
        0x39s
        0x41s
        0x42s
        0x43s
        0x44s
        0x45s
        0x46s
        0x47s
        0x48s
        0x49s
        0x4as
        0x4bs
        0x4cs
        0x4ds
        0x4es
        0x4fs
        0x50s
        0x51s
        0x52s
        0x53s
        0x54s
        0x55s
        0x56s
        0x57s
        0x58s
        0x59s
        0x5as
        0x61s
        0x62s
        0x63s
        0x64s
        0x65s
        0x66s
        0x67s
        0x68s
        0x69s
        0x6as
        0x6bs
        0x6cs
        0x6ds
        0x6es
        0x6fs
        0x70s
        0x71s
        0x72s
        0x73s
        0x74s
        0x75s
        0x76s
        0x77s
        0x78s
        0x79s
        0x7as
    .end array-data

    :array_1
    .array-data 2
        0x61s
        0x62s
        0x63s
        0x64s
        0x4cs
        0x4ds
        0x4es
        0x65s
        0x47s
        0x48s
        0x73s
        0x79s
        0x7as
        0x41s
        0x6es
        0x6fs
        0x4as
        0x4bs
        0x53s
        0x54s
        0x32s
        0x66s
        0x50s
        0x34s
        0x35s
        0x70s
        0x71s
        0x72s
        0x37s
        0x36s
        0x76s
        0x77s
        0x30s
        0x38s
        0x42s
        0x43s
        0x67s
        0x68s
        0x69s
        0x51s
        0x52s
        0x74s
        0x75s
        0x44s
        0x55s
        0x56s
        0x58s
        0x6ds
        0x31s
        0x45s
        0x46s
        0x78s
        0x59s
        0x5as
        0x33s
        0x4fs
        0x57s
        0x49s
        0x6as
        0x6bs
        0x6cs
        0x39s
    .end array-data
.end method

.method public constructor <init>()V
    .locals 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/entity/i;->b:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entity/i;->c:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entity/i;->d:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entity/i;->e:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entity/i;->f:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entity/i;->g:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entity/i;->h:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entity/i;->i:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entity/i;->j:Ljava/lang/Long;

    iput-object v0, p0, Lchat/ola/vn/entity/i;->k:Ljava/lang/Long;

    const/16 v1, 0x75

    iput-char v1, p0, Lchat/ola/vn/entity/i;->s:C

    const/4 v1, 0x0

    iput-boolean v1, p0, Lchat/ola/vn/entity/i;->t:Z

    iput-object v0, p0, Lchat/ola/vn/entity/i;->u:Ljava/util/List;

    const/4 v0, -0x1

    iput v0, p0, Lchat/ola/vn/entity/i;->w:I

    iput-boolean v1, p0, Lchat/ola/vn/entity/i;->t:Z

    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lchat/ola/vn/entity/i;->m:J

    iput v0, p0, Lchat/ola/vn/entity/i;->w:I

    return-void
.end method

.method private static final a([CLjava/lang/String;)J
    .locals 11

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    const-wide/16 v1, 0x0

    const-wide/16 v3, 0x1

    :goto_0
    if-ltz v0, :cond_2

    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v5

    array-length v6, p0

    add-int/lit8 v6, v6, -0x1

    :goto_1
    if-ltz v6, :cond_1

    aget-char v7, p0, v6

    if-ne v5, v7, :cond_0

    int-to-long v7, v6

    mul-long v7, v7, v3

    add-long v9, v1, v7

    move-wide v1, v9

    :cond_0
    add-int/lit8 v6, v6, -0x1

    goto :goto_1

    :cond_1
    array-length v5, p0

    int-to-long v5, v5

    mul-long v3, v3, v5

    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    :cond_2
    return-wide v1
.end method

.method public static a(Lchat/ola/vn/entity/i;Z)Ljava/lang/String;
    .locals 1

    invoke-virtual {p0}, Lchat/ola/vn/entity/i;->f()S

    move-result p1

    packed-switch p1, :pswitch_data_0

    const/4 p0, 0x0

    return-object p0

    :pswitch_0
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    :goto_0
    const-string v0, "http://web.kaspee.com/view?c="

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object p0

    :goto_1
    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0

    :pswitch_1
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    goto :goto_0

    :pswitch_2
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "http://web.kaspee.com/view?c="

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p0, "&w=0"

    goto :goto_1

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public static b(Ljava/lang/String;)[I
    .locals 5

    sget v0, Lchat/ola/vn/e;->c:I

    sget v1, Lchat/ola/vn/e;->c:I

    invoke-static {p0}, Lchat/ola/vn/entity/i;->e(Ljava/lang/String;)C

    move-result v2

    const/4 v3, 0x2

    const/16 v4, 0x34

    if-ne v2, v4, :cond_0

    const/4 v0, 0x7

    invoke-static {p0, v0, v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;II)Ljava/lang/String;

    move-result-object v0

    const/16 v1, 0x9

    invoke-static {p0, v1, v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;II)Ljava/lang/String;

    move-result-object p0

    invoke-static {v0}, Lchat/ola/vn/entity/i;->h(Ljava/lang/String;)J

    move-result-wide v0

    long-to-int v0, v0

    invoke-static {p0}, Lchat/ola/vn/entity/i;->h(Ljava/lang/String;)J

    move-result-wide v1

    long-to-int v1, v1

    :cond_0
    new-array p0, v3, [I

    const/4 v2, 0x0

    aput v0, p0, v2

    const/4 v0, 0x1

    aput v1, p0, v0

    return-object p0
.end method

.method public static d(Ljava/lang/String;)Ljava/lang/Long;
    .locals 12

    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/entity/i;->e(Ljava/lang/String;)C

    move-result v0

    const/16 v1, 0x33

    if-ne v0, v1, :cond_8

    invoke-static {p0}, Lchat/ola/vn/entity/i;->n(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    if-eqz p0, :cond_9

    invoke-virtual {p0}, Ljava/lang/String;->toCharArray()[C

    move-result-object p0

    array-length v0, p0

    const/4 v1, 0x6

    if-ne v0, v1, :cond_9

    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v0

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    :goto_0
    sget-object v7, Lchat/ola/vn/entity/i;->v:[C

    array-length v7, v7

    const/4 v8, 0x1

    if-ge v3, v7, :cond_7

    aget-char v7, p0, v2

    sget-object v9, Lchat/ola/vn/entity/i;->v:[C

    aget-char v9, v9, v3

    if-ne v7, v9, :cond_0

    const/16 v7, 0xb

    invoke-virtual {v0, v7, v3}, Ljava/util/Calendar;->set(II)V

    add-int/lit8 v4, v4, 0x1

    :cond_0
    aget-char v7, p0, v8

    sget-object v9, Lchat/ola/vn/entity/i;->v:[C

    aget-char v9, v9, v3

    if-ne v7, v9, :cond_1

    const/16 v7, 0xc

    invoke-virtual {v0, v7, v3}, Ljava/util/Calendar;->set(II)V

    add-int/lit8 v4, v4, 0x1

    :cond_1
    const/4 v7, 0x2

    aget-char v9, p0, v7

    sget-object v10, Lchat/ola/vn/entity/i;->v:[C

    aget-char v10, v10, v3

    const/4 v11, 0x5

    if-ne v9, v10, :cond_2

    invoke-virtual {v0, v11, v3}, Ljava/util/Calendar;->set(II)V

    add-int/lit8 v4, v4, 0x1

    :cond_2
    const/4 v9, 0x3

    aget-char v9, p0, v9

    sget-object v10, Lchat/ola/vn/entity/i;->v:[C

    aget-char v10, v10, v3

    if-ne v9, v10, :cond_3

    add-int/lit8 v9, v3, -0x1

    invoke-virtual {v0, v7, v9}, Ljava/util/Calendar;->set(II)V

    add-int/lit8 v4, v4, 0x1

    :cond_3
    const/4 v7, 0x4

    aget-char v7, p0, v7

    sget-object v9, Lchat/ola/vn/entity/i;->v:[C

    aget-char v9, v9, v3

    if-ne v7, v9, :cond_4

    add-int/lit8 v4, v4, 0x1

    move v6, v3

    :cond_4
    aget-char v7, p0, v11

    sget-object v9, Lchat/ola/vn/entity/i;->v:[C

    aget-char v9, v9, v3

    if-ne v7, v9, :cond_5

    add-int/lit8 v4, v4, 0x1

    move v5, v3

    :cond_5
    if-ne v4, v1, :cond_6

    goto :goto_1

    :cond_6
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_7
    :goto_1
    mul-int/lit8 v6, v6, 0x3e

    add-int/2addr v6, v5

    invoke-virtual {v0, v8, v6}, Ljava/util/Calendar;->set(II)V

    invoke-virtual {v0}, Ljava/util/Calendar;->getTimeInMillis()J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p0

    return-object p0

    :cond_8
    const/16 v1, 0x34

    if-ne v0, v1, :cond_9

    invoke-static {p0}, Lchat/ola/vn/entity/i;->g(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object p0

    if-eqz p0, :cond_9

    invoke-virtual {p0}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    const-wide v2, 0x13495104a80L

    add-long v4, v0, v2

    invoke-static {v4, v5}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    :cond_9
    const/4 p0, 0x0

    return-object p0
.end method

.method public static final e(Ljava/lang/String;)C
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result p0

    return p0
.end method

.method public static final f(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    invoke-static {p0}, Lchat/ola/vn/entity/i;->e(Ljava/lang/String;)C

    move-result v0

    const/16 v1, 0x34

    if-ne v0, v1, :cond_0

    const/16 v0, 0xd

    invoke-virtual {p0, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_0
    const/4 p0, 0x0

    return-object p0
.end method

.method public static final g(Ljava/lang/String;)Ljava/lang/Long;
    .locals 4

    invoke-static {p0}, Lchat/ola/vn/entity/i;->e(Ljava/lang/String;)C

    move-result v0

    const/16 v1, 0x34

    if-ne v0, v1, :cond_0

    invoke-static {p0}, Lchat/ola/vn/entity/i;->f(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    if-eqz p0, :cond_0

    invoke-static {p0}, Lchat/ola/vn/entity/i;->h(Ljava/lang/String;)J

    move-result-wide v0

    const-wide/16 v2, 0xa

    div-long/2addr v0, v2

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p0

    return-object p0

    :cond_0
    const/4 p0, 0x0

    return-object p0
.end method

.method public static final h(Ljava/lang/String;)J
    .locals 2

    sget-object v0, Lchat/ola/vn/entity/i;->a:[C

    invoke-static {v0, p0}, Lchat/ola/vn/entity/i;->a([CLjava/lang/String;)J

    move-result-wide v0

    return-wide v0
.end method

.method public static i(Ljava/lang/String;)C
    .locals 3

    const/4 v0, 0x0

    const/4 v1, 0x1

    :try_start_0
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/16 v2, 0x46

    if-eq p0, v2, :cond_3

    const/16 v2, 0x50

    if-eq p0, v2, :cond_2

    const/16 v1, 0x53

    if-eq p0, v1, :cond_1

    const/16 v1, 0x56

    if-eq p0, v1, :cond_0

    return v0

    :cond_0
    const/4 p0, 0x2

    return p0

    :cond_1
    const/4 p0, 0x3

    return p0

    :cond_2
    return v1

    :cond_3
    const/4 p0, 0x4

    return p0

    :catch_0
    return v0
.end method

.method public static k(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "http://web.kaspee.com/view?c="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p0, "&w="

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/16 p0, 0x500

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static l(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "http://web.kaspee.com/view?c="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static n(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    const/16 v1, 0x33

    if-lt v0, v1, :cond_0

    const/4 v0, 0x7

    const/4 v1, 0x6

    invoke-static {p0, v0, v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;II)Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_0
    const/4 p0, 0x0

    return-object p0
.end method


# virtual methods
.method public a()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/entity/i;->w:I

    return v0
.end method

.method public a(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/entity/i;->w:I

    return-void
.end method

.method public a(J)V
    .locals 0

    iput-wide p1, p0, Lchat/ola/vn/entity/i;->l:J

    return-void
.end method

.method public a(Ljava/lang/Long;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/i;->k:Ljava/lang/Long;

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 5

    const/4 v0, 0x0

    const/4 v1, 0x0

    if-nez p1, :cond_0

    :try_start_0
    iput-short v1, p0, Lchat/ola/vn/entity/i;->r:S

    iput-object v0, p0, Lchat/ola/vn/entity/i;->b:Ljava/lang/String;

    return-void

    :cond_0
    iput-object p1, p0, Lchat/ola/vn/entity/i;->b:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/entity/i;->b:Ljava/lang/String;

    const/4 v2, 0x1

    invoke-virtual {p1, v2}, Ljava/lang/String;->charAt(I)C

    move-result p1

    const/16 v3, 0x46

    if-eq p1, v3, :cond_3

    const/16 v3, 0x50

    if-eq p1, v3, :cond_4

    const/16 v3, 0x53

    const/4 v4, 0x2

    if-eq p1, v3, :cond_2

    const/16 v3, 0x56

    if-eq p1, v3, :cond_1

    iput-short v1, p0, Lchat/ola/vn/entity/i;->r:S

    goto :goto_2

    :cond_1
    iput-short v4, p0, Lchat/ola/vn/entity/i;->r:S
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/entity/i;->b:Ljava/lang/String;

    invoke-virtual {p1, v4}, Ljava/lang/String;->charAt(I)C

    move-result p1

    packed-switch p1, :pswitch_data_0

    :goto_0
    :pswitch_0
    iput-object v0, p0, Lchat/ola/vn/entity/i;->h:Ljava/lang/String;

    goto :goto_2

    :pswitch_1
    const-string p1, "avi"

    :goto_1
    iput-object p1, p0, Lchat/ola/vn/entity/i;->h:Ljava/lang/String;

    goto :goto_2

    :pswitch_2
    const-string p1, "mp4"

    goto :goto_1

    :pswitch_3
    const-string p1, "3gp"
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1

    :cond_2
    const/4 p1, 0x3

    :try_start_2
    iput-short p1, p0, Lchat/ola/vn/entity/i;->r:S
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :try_start_3
    iget-object p1, p0, Lchat/ola/vn/entity/i;->b:Ljava/lang/String;

    invoke-virtual {p1, v4}, Ljava/lang/String;->charAt(I)C

    move-result p1

    packed-switch p1, :pswitch_data_1

    goto :goto_0

    :pswitch_4
    const-string p1, "mp3"

    goto :goto_1

    :pswitch_5
    const-string p1, "wav"

    goto :goto_1

    :pswitch_6
    const-string p1, "mid"

    goto :goto_1

    :pswitch_7
    const-string p1, "amr"
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0

    goto :goto_1

    :cond_3
    const/4 p1, 0x4

    :try_start_4
    iput-short p1, p0, Lchat/ola/vn/entity/i;->r:S

    :cond_4
    iput-short v2, p0, Lchat/ola/vn/entity/i;->r:S

    const-string p1, "jpg"

    iput-object p1, p0, Lchat/ola/vn/entity/i;->h:Ljava/lang/String;

    :catch_0
    :goto_2
    iget-object p1, p0, Lchat/ola/vn/entity/i;->b:Ljava/lang/String;

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p1

    const/4 v0, 0x6

    if-le p1, v0, :cond_5

    iget-object p1, p0, Lchat/ola/vn/entity/i;->b:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result p1

    iput-char p1, p0, Lchat/ola/vn/entity/i;->s:C

    :cond_5
    iget-object p1, p0, Lchat/ola/vn/entity/i;->b:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/entity/i;->b(Ljava/lang/String;)[I

    move-result-object p1

    aget v0, p1, v1

    iput v0, p0, Lchat/ola/vn/entity/i;->p:I

    aget p1, p1, v2

    iput p1, p0, Lchat/ola/vn/entity/i;->q:I
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_1

    :catch_1
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x6d
        :pswitch_3
        :pswitch_2
        :pswitch_0
        :pswitch_1
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x61
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
    .end packed-switch
.end method

.method public a(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/i;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lchat/ola/vn/entity/i;->u:Ljava/util/List;

    return-void
.end method

.method public a(S)V
    .locals 0

    iput-short p1, p0, Lchat/ola/vn/entity/i;->r:S

    return-void
.end method

.method public b(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/entity/i;->o:I

    return-void
.end method

.method public b(J)V
    .locals 0

    iput-wide p1, p0, Lchat/ola/vn/entity/i;->n:J

    return-void
.end method

.method public b()Z
    .locals 1

    iget v0, p0, Lchat/ola/vn/entity/i;->w:I

    if-ltz v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public c()J
    .locals 2

    iget-wide v0, p0, Lchat/ola/vn/entity/i;->l:J

    return-wide v0
.end method

.method public c(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/i;->e:Ljava/lang/String;

    return-void
.end method

.method public d()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/i;->b:Ljava/lang/String;

    return-object v0
.end method

.method public e()C
    .locals 1

    iget-char v0, p0, Lchat/ola/vn/entity/i;->s:C

    return v0
.end method

.method public f()S
    .locals 1

    iget-short v0, p0, Lchat/ola/vn/entity/i;->r:S

    return v0
.end method

.method public g()Ljava/lang/Long;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/i;->k:Ljava/lang/Long;

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entity/i;->b:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entity/i;->b:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/entity/i;->d(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entity/i;->k:Ljava/lang/Long;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entity/i;->k:Ljava/lang/Long;

    return-object v0
.end method

.method public h()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/i;->g:Ljava/lang/String;

    return-object v0
.end method

.method public i()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/i;->h:Ljava/lang/String;

    return-object v0
.end method

.method public j()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/i;->c:Ljava/lang/String;

    return-object v0
.end method

.method public j(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/i;->g:Ljava/lang/String;

    return-void
.end method

.method public k()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/i;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/entity/i;->u:Ljava/util/List;

    return-object v0
.end method

.method public l()J
    .locals 2

    iget-wide v0, p0, Lchat/ola/vn/entity/i;->n:J

    return-wide v0
.end method

.method public m()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/i;->i:Ljava/lang/String;

    return-object v0
.end method

.method public m(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/i;->i:Ljava/lang/String;

    return-void
.end method
