.class public Lchat/ola/vn/entry/ImageEntry;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/os/Parcelable;


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator<",
            "Lchat/ola/vn/entry/ImageEntry;",
            ">;"
        }
    .end annotation
.end field

.field public static final a:[Ljava/lang/String;

.field public static final b:[Ljava/lang/String;


# instance fields
.field public c:J

.field public d:Ljava/lang/String;

.field public e:J

.field public f:Ljava/lang/String;

.field public g:J

.field public h:I

.field public i:J

.field public j:Ljava/lang/String;

.field private k:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lchat/ola/vn/entry/ImageEntry;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 8

    const/4 v0, 0x5

    new-array v1, v0, [Ljava/lang/String;

    const-string v2, "_id"

    const/4 v3, 0x0

    aput-object v2, v1, v3

    const-string v2, "_data"

    const/4 v4, 0x1

    aput-object v2, v1, v4

    const-string v2, "bucket_id"

    const/4 v5, 0x2

    aput-object v2, v1, v5

    const-string v2, "date_modified"

    const/4 v6, 0x3

    aput-object v2, v1, v6

    const-string v2, "bucket_display_name"

    const/4 v7, 0x4

    aput-object v2, v1, v7

    sput-object v1, Lchat/ola/vn/entry/ImageEntry;->a:[Ljava/lang/String;

    const/16 v1, 0x8

    new-array v1, v1, [Ljava/lang/String;

    const-string v2, "_id"

    aput-object v2, v1, v3

    const-string v2, "_data"

    aput-object v2, v1, v4

    const-string v2, "_size"

    aput-object v2, v1, v5

    const-string v2, "title"

    aput-object v2, v1, v6

    const-string v2, "date_modified"

    aput-object v2, v1, v7

    const-string v2, "orientation"

    aput-object v2, v1, v0

    const-string v0, "bucket_id"

    const/4 v2, 0x6

    aput-object v0, v1, v2

    const-string v0, "bucket_display_name"

    const/4 v2, 0x7

    aput-object v0, v1, v2

    sput-object v1, Lchat/ola/vn/entry/ImageEntry;->b:[Ljava/lang/String;

    new-instance v0, Lchat/ola/vn/entry/ImageEntry$1;

    invoke-direct {v0}, Lchat/ola/vn/entry/ImageEntry$1;-><init>()V

    sput-object v0, Lchat/ola/vn/entry/ImageEntry;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public constructor <init>(Landroid/os/Parcel;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    if-eqz p1, :cond_0

    :try_start_0
    invoke-virtual {p1}, Landroid/os/Parcel;->readLong()J

    move-result-wide v0

    iput-wide v0, p0, Lchat/ola/vn/entry/ImageEntry;->c:J

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/ImageEntry;->d:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/os/Parcel;->readLong()J

    move-result-wide v0

    iput-wide v0, p0, Lchat/ola/vn/entry/ImageEntry;->e:J

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/ImageEntry;->f:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/os/Parcel;->readLong()J

    move-result-wide v0

    iput-wide v0, p0, Lchat/ola/vn/entry/ImageEntry;->g:J

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    iput v0, p0, Lchat/ola/vn/entry/ImageEntry;->h:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readLong()J

    move-result-wide v0

    iput-wide v0, p0, Lchat/ola/vn/entry/ImageEntry;->i:J

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/ImageEntry;->j:Ljava/lang/String;

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->readArrayList(Ljava/lang/ClassLoader;)Ljava/util/ArrayList;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/entry/ImageEntry;->k:Ljava/util/ArrayList;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    return-void
.end method

.method public static a(Landroid/database/Cursor;)Lchat/ola/vn/entry/ImageEntry;
    .locals 3

    new-instance v0, Lchat/ola/vn/entry/ImageEntry;

    invoke-direct {v0}, Lchat/ola/vn/entry/ImageEntry;-><init>()V

    if-eqz p0, :cond_0

    invoke-interface {p0}, Landroid/database/Cursor;->getColumnCount()I

    move-result v1

    sget-object v2, Lchat/ola/vn/entry/ImageEntry;->b:[Ljava/lang/String;

    array-length v2, v2

    if-ne v1, v2, :cond_0

    const/4 v1, 0x0

    invoke-interface {p0, v1}, Landroid/database/Cursor;->getInt(I)I

    move-result v1

    int-to-long v1, v1

    iput-wide v1, v0, Lchat/ola/vn/entry/ImageEntry;->c:J

    const/4 v1, 0x1

    invoke-interface {p0, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lchat/ola/vn/entry/ImageEntry;->d:Ljava/lang/String;

    const/4 v1, 0x2

    invoke-interface {p0, v1}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v1

    iput-wide v1, v0, Lchat/ola/vn/entry/ImageEntry;->e:J

    const/4 v1, 0x3

    invoke-interface {p0, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lchat/ola/vn/entry/ImageEntry;->f:Ljava/lang/String;

    const/4 v1, 0x4

    invoke-interface {p0, v1}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v1

    iput-wide v1, v0, Lchat/ola/vn/entry/ImageEntry;->g:J

    const/4 v1, 0x5

    invoke-interface {p0, v1}, Landroid/database/Cursor;->getInt(I)I

    move-result v1

    iput v1, v0, Lchat/ola/vn/entry/ImageEntry;->h:I

    const/4 v1, 0x6

    invoke-interface {p0, v1}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v1

    iput-wide v1, v0, Lchat/ola/vn/entry/ImageEntry;->i:J

    const/4 v1, 0x7

    invoke-interface {p0, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object p0

    iput-object p0, v0, Lchat/ola/vn/entry/ImageEntry;->j:Ljava/lang/String;

    return-object v0

    :cond_0
    const/4 p0, 0x0

    return-object p0
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 2

    if-eqz p1, :cond_0

    iget-wide v0, p0, Lchat/ola/vn/entry/ImageEntry;->c:J

    invoke-virtual {p1, v0, v1}, Landroid/os/Parcel;->writeLong(J)V

    iget-object p2, p0, Lchat/ola/vn/entry/ImageEntry;->d:Ljava/lang/String;

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-wide v0, p0, Lchat/ola/vn/entry/ImageEntry;->e:J

    invoke-virtual {p1, v0, v1}, Landroid/os/Parcel;->writeLong(J)V

    iget-object p2, p0, Lchat/ola/vn/entry/ImageEntry;->f:Ljava/lang/String;

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-wide v0, p0, Lchat/ola/vn/entry/ImageEntry;->g:J

    invoke-virtual {p1, v0, v1}, Landroid/os/Parcel;->writeLong(J)V

    iget p2, p0, Lchat/ola/vn/entry/ImageEntry;->h:I

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeInt(I)V

    iget-wide v0, p0, Lchat/ola/vn/entry/ImageEntry;->i:J

    invoke-virtual {p1, v0, v1}, Landroid/os/Parcel;->writeLong(J)V

    iget-object p2, p0, Lchat/ola/vn/entry/ImageEntry;->j:Ljava/lang/String;

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object p2, p0, Lchat/ola/vn/entry/ImageEntry;->k:Ljava/util/ArrayList;

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeList(Ljava/util/List;)V

    :cond_0
    return-void
.end method
